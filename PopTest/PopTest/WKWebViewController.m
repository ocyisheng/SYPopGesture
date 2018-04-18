//
//  WKWebViewController.m
//  PopTest
//
//  Created by 高春阳 on 2018/4/18.
//  Copyright © 2018年 gao. All rights reserved.
//

#import "WKWebViewController.h"

#import <WebKit/WebKit.h>
@interface WKWebViewController ()
@property (nonatomic, strong) WKWebView *webView;
@property (weak, nonatomic) IBOutlet UISwitch *switch_wkwebGesture;
@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[WKWebView alloc]initWithFrame:self.view.bounds];
    self.webView.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:self.webView];
   [ self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    // Do any additional setup after loading the view from its nib.
    [self.view bringSubviewToFront:self.switch_wkwebGesture];
}
- (IBAction)wk_switchValueChange:(id)sender {
    //wkwebview 的后退返回手势不可用
    self.webView.allowsBackForwardNavigationGestures = self.switch_wkwebGesture.isOn;
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
