//
//  PhotoBrowserAnimator.h
//  PhotoBrowser
//
//  Created by ZhiHua Shen on 2018/5/7.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoBrowserAnimator : NSObject <UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>

@property (nonatomic,strong) UIView *fromView;

- (instancetype)initWith:(UIView *)fromView;

@end
