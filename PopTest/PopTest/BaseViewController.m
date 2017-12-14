//
//  BaseViewController.m
//  PopTest
//
//  Created by 高春阳 on 2017/12/13.
//  Copyright © 2017年 gao. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property (nonatomic,strong) UISwitch *swith;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (!_isSystemBackButton) {
        if (self.navigationController.viewControllers.count > 1 ) {
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
        }
    }
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    lable.text = @"手势";
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc]initWithCustomView:self.swith],[[UIBarButtonItem alloc]initWithCustomView:lable]];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UISwitch *)swith{
    if (!_swith) {
        _swith = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, 44, 30)];
        [_swith addTarget:self action:@selector(swithChange) forControlEvents:UIControlEventValueChanged];
        
        _swith.on = ! self.sy_interactivePopDisabled;
    }
    return _swith;
}

- (void)swithChange{
    self.sy_interactivePopDisabled = !self.swith.isOn;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
