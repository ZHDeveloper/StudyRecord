//
//  TVCloseView.m
//  TVCloseAnimation
//
//  Created by ZhiHua Shen on 2018/5/26.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "TVCloseView.h"
#import <objc/runtime.h>

@interface TVCloseView()<CAAnimationDelegate> {
    UIView *whiteView;
    CALayer *layer;
}

@end

@implementation TVCloseView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        whiteView = [[UIView alloc] init];
        whiteView.backgroundColor = [UIColor whiteColor];
        whiteView.frame = self.bounds;
        [self addSubview:whiteView];
    }
    return self;
}

- (void)startAnimation {
    
    CABasicAnimation *step1Ani = [CABasicAnimation animation];
    step1Ani.keyPath = @"transform.scale.y";

    step1Ani.fromValue = @(1);
    step1Ani.toValue = @(0.005);

    step1Ani.duration = 0.5;
    step1Ani.fillMode = kCAFillModeForwards;
    step1Ani.removedOnCompletion = NO;
    step1Ani.delegate = self;

    [whiteView.layer addAnimation:step1Ani forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    [whiteView removeFromSuperview];
    
    if (objc_getAssociatedObject(self, _cmd)) { return; }
    objc_setAssociatedObject(self, _cmd, @"Launch", OBJC_ASSOCIATION_RETAIN);
    
    CALayer *maskLayer = [self maskLayer];
    [self.layer addSublayer:maskLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.scale";
    
    animation.fromValue = @(1);
    animation.toValue = @(0);
    
    animation.duration = 0.5;
    
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    
    animation.delegate = self;
    
    [maskLayer addAnimation:animation forKey:nil];
}

- (CALayer *)maskLayer {
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    layer.backgroundColor = [UIColor blackColor].CGColor;
    layer.fillColor = [UIColor whiteColor].CGColor;
    
    CGRect rect = self.bounds;
    
    float offset = 2;
    float my = rect.size.height/2.0;

    UIBezierPath *aPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, my-2*offset, CGRectGetWidth(rect), 2*offset)];
    
    layer.path = aPath.CGPath;
    layer.frame = self.bounds;
    
    return layer;
}

- (void)layoutIfNeeded {
    [super layoutIfNeeded];
    
    whiteView.frame = self.bounds;
}

@end
