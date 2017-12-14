//
//  AppDelegate.m
//  PopTest
//
//  Created by 高春阳 on 2017/12/12.
//  Copyright © 2017年 gao. All rights reserved.
//

#import "AppDelegate.h"
#import "SYBaseNavigationController.h"
#import "HomeViewController.h"
@interface AppDelegate ()
@property (nonatomic,strong) SYBaseNavigationController *nav;

@property (nonatomic,strong) UISwitch *swith;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.    
    UITabBarController *tabbarVC = [[UITabBarController alloc]init];
    
    HomeViewController *vc1 = [[HomeViewController alloc]initWithNibName:NSStringFromClass([HomeViewController class]) bundle:nil];
    vc1.title = @"SYBaseNavigationController";
    SYBaseNavigationController * nav1 = [[SYBaseNavigationController alloc]initWithRootViewController:vc1];
    
    tabbarVC.viewControllers = @[nav1];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = tabbarVC;
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
