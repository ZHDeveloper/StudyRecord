//
//  UIView+SkeletonView.h
//  Test-OC
//
//  Created by ZhiHua Shen on 2018/6/9.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import <UIKit/UIKit.h>
@import SkeletonView;

@interface UIView (SkeletonView)

- (void)showSkeleton;

- (void)showGradientSkeleton;

- (void)showAnimatedSkeleton;

- (void)showAnimatedGradientSkeleton;

@end
