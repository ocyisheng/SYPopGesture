//
//  UIViewController+SYPopGesture.h
//  PopTest
//
//  Created by 高春阳 on 2017/12/14.
//  Copyright © 2017年 gao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SYPopGesture)<UIGestureRecognizerDelegate>
///禁止返回手势
@property (nonatomic,assign) BOOL sy_interactivePopDisabled;
//是否是全屏手势
@property (nonatomic,assign) BOOL sy_isFullPopGesture;
@end
