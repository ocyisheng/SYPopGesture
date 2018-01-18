//
//  SYPageViewController.m
//  PopTest
//
//  Created by 高春阳 on 2017/12/18.
//  Copyright © 2017年 gao. All rights reserved.
//

#import "SYPageViewController.h"

@interface SYPageViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate,UIScrollViewDelegate>
@property (nonatomic,strong) UIPageViewController *pageViewController;

@property (nonatomic,strong) NSMutableArray *vcArray;

@property (nonatomic,copy) NSString *conformsProtocolViewControllerClassString;

@property (nonatomic,assign) NSUInteger maxPages;

@property (nonatomic,assign) UIPageViewControllerNavigationOrientation navigationOrientation;
@property (nonatomic,assign) CGFloat pageSpacing;

@property (nonatomic,strong) UIScrollView *contentScrollView;
@end

@implementation SYPageViewController

- (instancetype)initWithConformsProtocolViewController:(NSString *)vcClassName{
    if (self = [super init]) {
        _navigationOrientation = UIPageViewControllerNavigationOrientationHorizontal;
        _pageSpacing = 8.f;
        _conformsProtocolViewControllerClassString = vcClassName;
        _maxPages = NSUIntegerMax;
    }
    return self;
}
- (instancetype)initWithConformsProtocolViewController:(NSString *)vcClassName
                                 navigationOrientation:(UIPageViewControllerNavigationOrientation)orientation
                                           pageSpacing:(CGFloat)pageSpacing{
    if (self = [super init]) {
        _navigationOrientation = orientation;
        _pageSpacing = pageSpacing;
        _conformsProtocolViewControllerClassString = vcClassName;
        _maxPages = NSUIntegerMax;
    }
    return self;
}

- (void)addChildViewControllerTo:(UIViewController *)viewConroller{
    self.pageViewController.view.frame = viewConroller.view.bounds;
    [viewConroller addChildViewController:self.pageViewController];
    [viewConroller.view addSubview:self.pageViewController.view];
}

- (void)showFirstVisiableViewControllerWithPageNumber:(NSUInteger)pageNumber{
    [self showConformsProtocolViewControllerWithPageNumber:pageNumber
                                                 direction:UIPageViewControllerNavigationDirectionForward
                                                 animation:NO];
}
- (void)showLastVisiableViewController{
    __weak typeof(self) weakSelf = self;
    [self showNextConformsProtocolViewControllerWithDirection:UIPageViewControllerNavigationDirectionReverse
                         animation:YES
                        completion:^(BOOL finished, UIViewController<SYPageViewControllerProtocol> *conformsProtocolViewController) {
                            [weakSelf.dataSource didDisplayVisiableViewController:conformsProtocolViewController];
                        }];
}
- (void)showNextVisiableViewController{
    __weak typeof(self) weakSelf = self;
    [self showNextConformsProtocolViewControllerWithDirection:UIPageViewControllerNavigationDirectionForward
                         animation:YES
                        completion:^(BOOL finished, UIViewController<SYPageViewControllerProtocol> *conformsProtocolViewController) {
                           [weakSelf.dataSource didDisplayVisiableViewController:conformsProtocolViewController];
                        }];
}
- (void)showConformsProtocolViewControllerWithPageNumber:(NSUInteger)pageNumber
                                               direction:(UIPageViewControllerNavigationDirection)direction
                                              animation:(BOOL)animation{
    UIViewController<SYPageViewControllerProtocol> * vc = self.vcArray[0];
    if (pageNumber != 0) {
        vc.currenPageNumber = pageNumber - 1;
        vc = self.vcArray[2];
        vc.currenPageNumber = pageNumber + 1;
        // 取中间的
        vc = self.vcArray[1];
    }
    vc.currenPageNumber = pageNumber;
    __weak typeof(self) weakSelf = self;
    [self.pageViewController setViewControllers:@[vc] direction:direction animated:animation completion:^(BOOL finished) {
       [weakSelf.dataSource didDisplayVisiableViewController:vc];
    }];
}

#pragma mark - UIPageViewControllerDataSource
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    UIViewController<SYPageViewControllerProtocol> *svc = [self nextConformsProtocolViewControllerWithCurrentVC:(UIViewController<SYPageViewControllerProtocol> *)viewController isAfter:NO];
    return  [self.dataSource didDisplayVisiableViewController:svc];
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    UIViewController<SYPageViewControllerProtocol> *svc = [self nextConformsProtocolViewControllerWithCurrentVC:(UIViewController<SYPageViewControllerProtocol> *)viewController isAfter:YES];
    return  [self.dataSource didDisplayVisiableViewController:svc];
}
#pragma mark - Private Method
- (void)showNextConformsProtocolViewControllerWithDirection:(UIPageViewControllerNavigationDirection)direction
                       animation:(BOOL)animation
                      completion:(void (^ __nullable)(BOOL finished,UIViewController<SYPageViewControllerProtocol> *conformsProtocolViewController))completion{
    
    BOOL isAfter = (direction == UIPageViewControllerNavigationDirectionForward) ? YES : NO;
    UIViewController<SYPageViewControllerProtocol> *nextVC = [self nextConformsProtocolViewControllerWithCurrentVC:self.pageViewController.viewControllers.lastObject
                                               isAfter:isAfter];
    if (nextVC == nil) {
        completion(YES,nil);
        return;
    }
    [self.pageViewController setViewControllers:@[nextVC]
                          direction:direction
                           animated:animation
                         completion:^(BOOL finished) {
                             //调用块
                             completion(finished,nextVC);
                         }];
}
- (UIViewController<SYPageViewControllerProtocol> *)nextConformsProtocolViewControllerWithCurrentVC:(UIViewController<SYPageViewControllerProtocol> *)conformsProtocolViewController isAfter:(BOOL)isAfter{
    if (conformsProtocolViewController == nil){
        return nil;
    }
    NSInteger currenPageNumber = conformsProtocolViewController.currenPageNumber;
    
    if (isAfter == YES && currenPageNumber >=self.maxPages- 1){
        //当前页面是最后一个时，向后滚动，则不再滚动
        return nil;
    }else if (isAfter == NO && currenPageNumber <= 0){
        //当前页面是第一个时，向前滚动，则不再滚动
        return nil;
    }
    
    NSUInteger vcIndex = [self.vcArray indexOfObject:conformsProtocolViewController];
    
    if (isAfter) {
        if (vcIndex == self.vcArray.count - 1) {
            vcIndex = 0;
        }else{
            //依次向后
            vcIndex ++;
        }
        //下一页码
        currenPageNumber ++;
    }else{
        if (vcIndex == 0) {
            vcIndex = self.vcArray.count - 1;
        }else{
            //依次向前
            vcIndex --;
        }
        //下一页码
        currenPageNumber --;
    }
    UIViewController<SYPageViewControllerProtocol> *myVC  = [self.vcArray objectAtIndex:vcIndex];
    myVC.currenPageNumber = currenPageNumber;
    return myVC;
}
#pragma mark - Getter Method

- (UIScrollView *)contentScrollView{
    if (!_contentScrollView) {
        [self.pageViewController.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[UIScrollView class]]) {
                _contentScrollView = obj;
                _contentScrollView.delegate = self;
                *stop = YES;
            }
        }];
    }
    return _contentScrollView;
}
- (UIPageViewController *)pageViewController{
    if (!_pageViewController) {
        NSDictionary *option = @{UIPageViewControllerOptionInterPageSpacingKey:@(self.pageSpacing)};
        _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:self.navigationOrientation options:option];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
    }
    return _pageViewController;
}

- (NSMutableArray *)vcArray{
    if (!_vcArray) {
        _vcArray = [NSMutableArray array];
        for (int i = 0; i < 3; i ++) {
            UIViewController<SYPageViewControllerProtocol> *vc = [[[NSClassFromString(self.conformsProtocolViewControllerClassString) class] alloc]init];
            vc.currenPageNumber = i;
            vc.view.backgroundColor = [UIColor whiteColor];
            [_vcArray addObject:vc];
        }
    }
    return _vcArray;
}
@end
