//
//  LeftButtonItemViewController.m
//  PopTest
//
//  Created by 高春阳 on 2017/12/13.
//  Copyright © 2017年 gao. All rights reserved.
//

#import "LeftButtonItemViewController.h"


@interface LeftButtonItemViewController ()

@end

@implementation LeftButtonItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.sy_isFullPopGesture = YES;
     self.title = @"全屏返回手势";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pusNextVC:(id)sender {
    
    LeftButtonItemViewController * vc = [[LeftButtonItemViewController alloc]initWithNibName:NSStringFromClass([LeftButtonItemViewController class]) bundle:nil];
    
//    UIViewController *vc = [UIViewController new];
//    vc.view.backgroundColor = [UIColor redColor];
//    vc.title = @"UIViewController";
//    vc.sy_isFullPopGesture = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
