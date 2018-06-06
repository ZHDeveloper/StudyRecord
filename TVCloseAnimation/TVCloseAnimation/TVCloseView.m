//
//  TVCloseView.m
//  TVCloseAnimation
//
//  Created by ZhiHua Shen on 2018/5/26.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "TVCloseView.h"
#import <objc/runtime.h>

const NSString *_Nullable kStep1Anim = @"kStep1Anim";
const NSString *_Nullable kStep2Anim = @"kStep2Anim";

@interface TVCloseView()<CAAnimationDelegate> {
    UIView *whiteView;
}

@property (nonatomic,strong) CALayer *maskLayer;

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
    
    CAAnimation *animatione = [self step1Animation];
    
    [whiteView.layer addAnimation:animatione forKey:@"kStep1Anim"];
}

- (CAAnimation *)step1Animation {
    
    CABasicAnimation *step1Ani = [CABasicAnimation animation];
    step1Ani.keyPath = @"transform.scale.y";
    
    step1Ani.fromValue = @(1);
    step1Ani.toValue = @(0.005);
    
    step1Ani.beginTime = CACurrentMediaTime();
    step1Ani.duration = 0.5;
    
    step1Ani.fillMode = kCAFillModeForwards;
    step1Ani.removedOnCompletion = NO;
    step1Ani.delegate = self;
    
    return step1Ani;
}

- (CAAnimation *)step2Animation {
    
    CABasicAnimation *step2Ani = [CABasicAnimation animation];
    step2Ani.keyPath = @"transform.scale";
    
    step2Ani.fromValue = @(1);
    step2Ani.toValue = @(0);
    
    step2Ani.duration = 0.5;
    
    step2Ani.fillMode = kCAFillModeForwards;
    step2Ani.removedOnCompletion = NO;
    
    step2Ani.delegate = self;
    
    return step2Ani;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    CAAnimation *animOne = [whiteView.layer animationForKey:@"kStep1Anim"];
    CAAnimation *animTwo = [self.maskLayer animationForKey:@"kStep2Anim"];
    
    if (animOne == anim) {
        [whiteView removeFromSuperview];
        
        [self.layer addSublayer:self.maskLayer];
        
        CAAnimation *animation = [self step2Animation];
        [self.maskLayer addAnimation:animation forKey:@"kStep2Anim"];
    }
    else if (animTwo == anim) {
        [self.maskLayer removeAllAnimations];
        exit(0);
    }
}

- (CALayer *)maskLayer {
    
    if (!_maskLayer) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        
        layer.backgroundColor = [UIColor blackColor].CGColor;
        layer.fillColor = [UIColor whiteColor].CGColor;
        
        CGRect rect = self.bounds;
        
        float offset = 2;
        float my = rect.size.height/2.0;
        
        UIBezierPath *aPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, my-2*offset, CGRectGetWidth(rect), 2*offset)];
        
        layer.path = aPath.CGPath;
        layer.frame = self.bounds;
        
        _maskLayer = layer;
    }
    
    return _maskLayer;
}

- (void)layoutIfNeeded {
    [super layoutIfNeeded];
    
    whiteView.frame = self.bounds;
}

@end
