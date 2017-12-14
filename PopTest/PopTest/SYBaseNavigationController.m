//
//  SYBaseNavigationController.m
//  SHIYUN
//
//  Created by 高春阳 on 2017/9/26.
//  Copyright © 2017年 gao. All rights reserved.
//

#import "SYBaseNavigationController.h"

@interface SYBaseNavigationController ()

@end
@implementation SYBaseNavigationController
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        //隐藏tabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}
@end
