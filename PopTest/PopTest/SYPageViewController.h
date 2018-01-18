//
//  SYPageViewController.h
//  PopTest
//
//  Created by 高春阳 on 2017/12/18.
//  Copyright © 2017年 gao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SYPageViewControllerProtocol <NSObject>
@required
@property (nonatomic,assign) NSUInteger currenPageNumber;
@end

@protocol SYPageViewControllerDataSource <NSObject>
@required

/**
 可见VC加载完毕，可以在这里更新VC的内容

 @param visiableViewController 遵守SYPageViewControllerProtocol协议的VC
 @return visiableViewController
 */
- (UIViewController<SYPageViewControllerProtocol> *)didDisplayVisiableViewController:(UIViewController<SYPageViewControllerProtocol> *)visiableViewController;

@end

@interface SYPageViewController : NSObject
@property (nonatomic,weak) id<SYPageViewControllerDataSource> dataSource;

/**
 初始化 SYPageViewController；默认水平滚动，书脊宽为8.f

 @param vcClassName 遵循SYPageViewControllerProtocol协议，需要展示的VCName
 @return self
 */
- (instancetype)initWithConformsProtocolViewController:(NSString *)vcClassName;

/**
 初始化 SYPageViewController

 @param vcClassName 遵循SYPageViewControllerProtocol协议，需要展示的VC
 @param orientation 滚动方向
 @param pageSpacing 书脊宽度
 @return self
 */
- (instancetype)initWithConformsProtocolViewController:(NSString *)vcClassName
                                 navigationOrientation:(UIPageViewControllerNavigationOrientation)orientation
                                           pageSpacing:(CGFloat)pageSpacing;
///添加SYPageViewController；默认SYPageViewController的view.frame = viewConroller.view.bounds
- (void)addChildViewControllerTo:(UIViewController *)viewConroller;
///第一次显示指定页面
- (void)showFirstVisiableViewControllerWithPageNumber:(NSUInteger)pageNumber;
///跳转上一页面
- (void)showLastVisiableViewController;
///跳转下一页面
- (void)showNextVisiableViewController;
///跳转到指定页码
- (void)showConformsProtocolViewControllerWithPageNumber:(NSUInteger)pageNumber
                                               direction:(UIPageViewControllerNavigationDirection)direction
                                               animation:(BOOL)animation;

@end
