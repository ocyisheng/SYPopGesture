//
//  PageViewController.m
//  PopTest
//
//  Created by 高春阳 on 2017/12/13.
//  Copyright © 2017年 gao. All rights reserved.
//

#import "PageViewController.h"

@interface MyStoryVC : UIViewController
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,assign) NSInteger currenPageNumber;//当前的页码，在pageView中的位置
@end

@interface PageViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource>
@property (nonatomic,strong) UIPageViewController *pageVC;

@property (nonatomic,strong) NSMutableArray<MyStoryVC *> *vcArray;

@property (nonatomic,assign) NSInteger maxPages;//最大的页码
@property (weak, nonatomic) IBOutlet UIButton *lastButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;


@end
/*
 
 1.使用3个storyVC 交替使用，减少vc的创建量
 2.使用maxPages限制总的页码数，
 3.使用currenPageNumber 标记该storyVC 在 pageViewController中的位置
 */
@implementation PageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.maxPages = 10;
    self.pageVC.view.frame = self.view.bounds;
    [self addChildViewController:self.pageVC];
    [self.view addSubview:self.pageVC.view];
    
    MyStoryVC *mvc1 = self.vcArray[0];
    mvc1.label.text = @"这是第1页";
    [self.pageVC setViewControllers:@[mvc1] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self.view bringSubviewToFront:self.nextButton];
    [self.view bringSubviewToFront:self.lastButton];
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    MyStoryVC *svc = [self nextStroyVCWithCurrentVC:(MyStoryVC *)viewController isAfter:NO];
    svc.label.text = [NSString stringWithFormat:@"这是第%ld页",svc.currenPageNumber + 1];
    return svc;
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    MyStoryVC *svc = [self nextStroyVCWithCurrentVC:(MyStoryVC *)viewController isAfter:YES];
    svc.label.text = [NSString stringWithFormat:@"这是第%ld页",svc.currenPageNumber + 1];
    return svc;
}

- (IBAction)lastPage:(id)sender {
    [self showReverseStoryVC];
}
- (IBAction)nextPage:(id)sender {
    [self showForwardStoryVC];
}
- (void)showForwardStoryVC{
    [self showStoryVCWithDirection:UIPageViewControllerNavigationDirectionForward
                         animation:YES
                        completion:^(BOOL finished, MyStoryVC *storyVC) {
         storyVC.label.text = [NSString stringWithFormat:@"这是第%ld页",storyVC.currenPageNumber + 1];
    }];
}
- (void)showReverseStoryVC{
    [self showStoryVCWithDirection:UIPageViewControllerNavigationDirectionReverse
                         animation:YES
                        completion:^(BOOL finished, MyStoryVC *storyVC) {
         storyVC.label.text = [NSString stringWithFormat:@"这是第%ld页",storyVC.currenPageNumber + 1];
    }];
}
- (void)showStoryVCWithDirection:(UIPageViewControllerNavigationDirection)direction
                       animation:(BOOL)animation
                      completion:(void (^ __nullable)(BOOL finished,MyStoryVC *storyVC))completion{
    
    BOOL isAfter = (direction == UIPageViewControllerNavigationDirectionForward) ? YES : NO;
    MyStoryVC *nextVC = [self nextStroyVCWithCurrentVC:self.pageVC.viewControllers.lastObject
                                               isAfter:isAfter];
    if (nextVC == nil) {
        completion(YES,nil);
        return;
    }
    [self.pageVC setViewControllers:@[nextVC]
                          direction:direction
                           animated:animation
                         completion:^(BOOL finished) {
        //调用块
        completion(finished,nextVC);
    }];
}
- (MyStoryVC *)nextStroyVCWithCurrentVC:(MyStoryVC *)storyVC isAfter:(BOOL)isAfter{
    if (storyVC == nil){
        return nil;
    }
    
    NSInteger currenPageNumber = storyVC.currenPageNumber;
    
    if (isAfter == YES && currenPageNumber >=self.maxPages- 1){
        //当前页面是最后一个时，向后滚动，则不再滚动
        return nil;
    }else if (isAfter == NO && currenPageNumber <= 0){
        //当前页面是第一个时，向前滚动，则不再滚动
        return nil;
    }
    
    NSUInteger vcIndex = [self.vcArray indexOfObject:storyVC];
    
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
    MyStoryVC *myVC  = [self.vcArray objectAtIndex:vcIndex];
    myVC.currenPageNumber = currenPageNumber;
    return myVC;
}
- (UIPageViewController *)pageVC{
    if (!_pageVC) {
         NSDictionary *option = @{UIPageViewControllerOptionInterPageSpacingKey:@(10.f)};
        _pageVC = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:option];
        _pageVC.delegate = self;
        _pageVC.dataSource = self;
    }
    return _pageVC;
}

- (NSMutableArray<MyStoryVC *> *)vcArray{
    if (!_vcArray) {
        _vcArray = [NSMutableArray array];
        for (int i = 0; i < 3 ; i ++) {
            MyStoryVC * svc = [[MyStoryVC alloc]init];
            //初始化
            svc.currenPageNumber = i;
            svc.view.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:1.f- i/3.f];
            [self.vcArray addObject:svc];
        }
    }
    return _vcArray;
}
@end

@implementation MyStoryVC

- (void)viewDidLoad{
    [super viewDidLoad];

    self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.bounds), 44)];
    
    self.label.backgroundColor = [UIColor grayColor];
    
    self.label.textColor = [UIColor blueColor];
    
    self.label.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:self.label];
}

@end
