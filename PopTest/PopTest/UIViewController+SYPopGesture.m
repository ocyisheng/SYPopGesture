//
//  UIViewController+SYPopGesture.m
//  PopTest
//
//  Created by 高春阳 on 2017/12/14.
//  Copyright © 2017年 gao. All rights reserved.
//

#import "UIViewController+SYPopGesture.h"
#import <objc/runtime.h>
#import <WebKit/WebKit.h>

@implementation UIViewController (SYPopGesture)
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethod = class_getInstanceMethod(self, @selector(viewDidLoad));
        Method swizzledMethod = class_getInstanceMethod(self, @selector(syPop_viewDidLoad));
        method_exchangeImplementations(originalMethod, swizzledMethod);
    });
}
- (void)syPop_viewDidLoad{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.02 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [self addPanGesutre];
    });
     [self syPop_viewDidLoad];
}
- (void)addPanGesutre{
    //parentViewController考虑到 addChildViewController 的情况；只有当是push出的viewController时，再添加自定义的手势
    if ([self.parentViewController isKindOfClass:[UINavigationController class]]) {
         if (self.navigationController.viewControllers.count > 1) {
            //使用自定义的手势替换系统的侧边触发手势，
            //设置手势的代理
            [self syPanGesture].delegate = self;
            //将自定义手势添加到vc的view上
            [self.view addGestureRecognizer:[self syPanGesture]];
        }
    }
}
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    if ([[self.navigationController valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    if ([self.navigationController.transitionCoordinator isAnimated]) {
        return NO;
    }
    if (self.navigationController.viewControllers.count < 2) {
        return NO;
    }
    if (self.sy_interactivePopDisabled) {
        return NO;
    }
    // 侧滑手势触发位置
    CGPoint location = [gestureRecognizer locationInView:self.view];
    CGPoint offSet = [gestureRecognizer translationInView:gestureRecognizer.view];
    //触发宽度，
    CGFloat maxLocationX = self.sy_isFullPopGesture == YES ? CGRectGetWidth(self.view.bounds) : 44.f;
    //当是全屏返回手势时，使用整个宽度
    BOOL ret = (0 < offSet.x && location.x <= maxLocationX);
    return ret;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    //当syPanGesture响应失败时，才响应scrollView的拖动手势
    [otherGestureRecognizer requireGestureRecognizerToFail:gestureRecognizer];
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    //当self.view添加有WKWebView时，适配 wkwebView.allowsBackForwardNavigationGestures == YES 手势
    if ([self sy_wkWebViewCanallowsBackForwardNavigationGestures]) {
        return NO;
    }
    //当拖动的是slider时，该事件不让syPanGesture手势响应
    if ([touch.view isKindOfClass:[UISlider class]]) {
        return NO;
    }
    return YES;
}
- (BOOL )sy_wkWebViewCanallowsBackForwardNavigationGestures{
    __block WKWebView *webView = nil;
    [self.view.subviews enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[WKWebView class]]) {
            webView = obj;
            *stop = YES;
        }
    }];
    if (webView.allowsBackForwardNavigationGestures == YES && webView.canGoBack == YES) {
        return YES;
    }
    return NO;
}
#pragma mark - getter setter method
- (void)setSy_interactivePopDisabled:(BOOL)sy_interactivePopDisabled{
    objc_setAssociatedObject(self, @selector(sy_interactivePopDisabled), @(sy_interactivePopDisabled), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)sy_interactivePopDisabled{
    NSNumber *num = objc_getAssociatedObject(self, _cmd);
    return num.boolValue;
}
- (UIPanGestureRecognizer *)syPanGesture{
    UIPanGestureRecognizer *panGesture = objc_getAssociatedObject(self, _cmd);
    if (panGesture == nil) {
        //设置系统手势不可用
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        //获取手势的代理对象
        id target = self.navigationController.interactivePopGestureRecognizer.delegate;
        //获取手势响应的方法
        SEL backGestureSelector = NSSelectorFromString(@"handleNavigationTransition:");
        panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:target action:backGestureSelector];
        objc_setAssociatedObject(self, @selector(syPanGesture), panGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return panGesture;
}
- (BOOL)sy_isFullPopGesture{
    NSNumber *num = objc_getAssociatedObject(self, _cmd);
    return num.boolValue;
}
- (void)setSy_isFullPopGesture:(BOOL)sy_isFullPopGesture{
    objc_setAssociatedObject(self, @selector(sy_isFullPopGesture), @(sy_isFullPopGesture), OBJC_ASSOCIATION_ASSIGN);
}
/*
 参考：
 1。 iOS统一设定导航栏返回按钮 + 自定义Pan返回手势 +Pop转场错乱
 http://www.jianshu.com/p/e4b29ead050b
 
 
 2.一行代码，让你的应用中UIScrollView的滑动与侧滑返回并存
 http://www.jianshu.com/p/8170fea174da
 
 3.FDFullscreenPopGesture
 https://github.com/forkingdog/FDFullscreenPopGesture
 */

@end
