//
//  ImplicitAnimationViewController.m
//  点滴记录
//
//  Created by ZhiHua Shen on 2018/4/16.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "ImplicitAnimationViewController.h"

@interface ImplicitAnimationViewController () {
    CALayer *_layer;
    UIView *_centerView;
}

@end

@implementation ImplicitAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [self.view addSubview:centerView];
    
    centerView.center = self.view.center;
    
    centerView.backgroundColor = [UIColor greenColor];
    
    _centerView = centerView;
}

- (void)initialDefaultTransationLayer {
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [self.view addSubview:centerView];
    
    centerView.center = self.view.center;
    
    centerView.backgroundColor = [UIColor clearColor];
    
    CALayer *layer = [CALayer layer];
    _layer = layer;
    layer.frame = centerView.bounds;
    
    layer.backgroundColor = [UIColor greenColor].CGColor;
    
    [centerView.layer addSublayer:layer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self defaultTransation];
    [self colorAnimation];
}

- (void)defaultTransation {
    [CATransaction begin];
    [CATransaction setAnimationDuration:1];
    [CATransaction setCompletionBlock:^{
        [CATransaction setAnimationDuration:1];
        self->_layer.affineTransform = CGAffineTransformRotate(self->_layer.affineTransform, M_PI_4);
    }];
    _layer.backgroundColor = RandomColor.CGColor;
    [CATransaction commit];
}

- (void)colorAnimation {
    _centerView.alpha = 1;
//    _centerView.backgroundColor = RandomColor;
    _centerView.alpha = 0.4;
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.duration = 2;
    [_centerView.layer addAnimation:transition forKey:nil];
}

@end
