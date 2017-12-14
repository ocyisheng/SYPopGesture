//
//  ScrollViewController.m
//  PopTest
//
//  Created by 高春阳 on 2017/12/13.
//  Copyright © 2017年 gao. All rights reserved.
//

#import "ScrollViewController.h"

@interface ScrollViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *pusButton;

@end

@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds) * 2.f, CGRectGetHeight(self.view.bounds));
    [self.view bringSubviewToFront:self.pusButton];
    
}
- (IBAction)pushNext:(id)sender {
    
    ScrollViewController *scroVC = [[ScrollViewController alloc]initWithNibName:NSStringFromClass([ScrollViewController class]) bundle:nil];
    [self.navigationController pushViewController:scroVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
