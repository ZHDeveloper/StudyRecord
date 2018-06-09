//
//  UIView+SkeletonView.m
//  Test-OC
//
//  Created by ZhiHua Shen on 2018/6/9.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "UIView+SkeletonView.h"

#define HexColor(rgbValue) [UIColor colorWithRed: ((float)((rgbValue & 0xFF0000) >> 16))/255.0 green: ((float)((rgbValue & 0xFF00) >> 8))/255.0 blue: ((float)(rgbValue & 0xFF))/255.0 alpha: 1.0]

@implementation UIView (SkeletonView)

- (void)showSkeleton {
    [self showSkeletonUsingColor:HexColor(0xecf0f1)];
}

- (void)showGradientSkeleton {
    SkeletonGradient *gradient = [[SkeletonGradient alloc] initWithBaseColor:HexColor(0xecf0f1) secondaryColor:nil];
    [self showGradientSkeletonUsingGradient:gradient];
}

- (void)showAnimatedSkeleton {
    [self showAnimatedSkeletonUsingColor:HexColor(0xecf0f1) animation:nil];
}

- (void)showAnimatedGradientSkeleton {
    [self showAnimatedSkeletonUsingColor:HexColor(0xecf0f1) animation:nil];
}

@end
