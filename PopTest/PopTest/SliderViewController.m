//
//  SliderViewController.m
//  PopTest
//
//  Created by 高春阳 on 2017/12/13.
//  Copyright © 2017年 gao. All rights reserved.
//

#import "SliderViewController.h"

@interface SliderViewController ()
@property (weak, nonatomic) IBOutlet UISlider *slider;

@end

@implementation SliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.slider.minimumValue = 1.f;
    self.slider.maximumValue = 100.f;
    // Do any additional setup after loading the view from its nib.
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)valueChanged:(UISlider *)sender {
    NSLog(@"valueChanged:%f",self.slider.value);
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
