//
//  LaunchViewController.m
//  TwitterLaunchAnimation
//
//  Created by ZhiHua Shen on 2018/5/24.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "LaunchViewController.h"

@interface LaunchViewController ()<CAAnimationDelegate> {
    CALayer *maskLayer;
    UIImageView *bgView;
}

@end

@implementation LaunchViewController

- (instancetype)initWithDummyImage:(UIImage *)image {
    if ([super init]) {
        self.dummyImage = image;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    bgView = [[UIImageView alloc] init];
    
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.image = self.dummyImage;
    
    bgView.frame = self.view.bounds;
    [self.view addSubview:bgView];
    
    self.view.backgroundColor = [UIColor colorNamed:@"twitterColor"];
    
    CALayer *layer = [CALayer layer];
    maskLayer = layer;
    
    layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"twitter logo mask"].CGImage);
    
    layer.frame = CGRectMake(0, 0, 120, 98);
    
    bgView.layer.mask = layer;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self startAnimation];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self animationDidStop:nil finished:nil];
//    });
}

- (void)startAnimation {
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    animation.beginTime = CACurrentMediaTime() + 0.5;
    animation.duration = 1.5;
    animation.values = @[@(1),@(0.8),@(15)];
    
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    animation.delegate = self;
    
    [maskLayer addAnimation:animation forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
        
    [self.view removeFromSuperview];
    
    [self removeFromParentViewController];
    [self willMoveToParentViewController:nil];
    
    [maskLayer removeAllAnimations];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    bgView.frame = self.view.bounds;
    maskLayer.position = self.view.center;
}

- (void)dealloc {
    NSLog(@"LaunchViewController dealloc");
}

@end
