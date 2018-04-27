//
//  CAGradientLayerViewController.m
//  点滴记录
//
//  Created by ZhiHua Shen on 2018/4/10.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "CAGradientLayerViewController.h"

#define MINLINE_FLOAT 0.000000001

@interface CAGradientLayerViewController ()


@end

@implementation CAGradientLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FlashView *view = [[FlashView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];

    view.center = self.view.center;
    [self.view addSubview:view];
    
    
}

@end

@implementation ProgressView

+ (Class)layerClass {
    return [CAGradientLayer class];
}

- (CAGradientLayer *)gradientLayer {
    return (CAGradientLayer *)self.layer;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        _progressLayer = [self progressLayer];
        _animation = [self animation];
        
        self.gradientLayer.colors = @[(__bridge id)[UIColor greenColor].CGColor, (__bridge id)[UIColor yellowColor].CGColor];
        
        self.gradientLayer.startPoint = CGPointMake(0, 0.5);
        self.gradientLayer.endPoint = CGPointMake(1, 0.5);
        
        self.gradientLayer.mask = _progressLayer;
    }
    return self;
}

- (void)startAnimation {
    [_progressLayer addAnimation:_animation forKey:nil];
}

- (CAShapeLayer *)progressLayer {
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    layer.lineWidth = 10;
    
    layer.strokeColor = [UIColor yellowColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineCap = @"round";
    
    CGFloat radius = 100;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.center radius:radius startAngle:(M_PI*3.0)/4.0 endAngle:M_PI*2+M_PI/4.0 clockwise:YES];
    
    layer.path = path.CGPath;
        
    return layer;
}

- (CABasicAnimation *)animation {
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    animation.fromValue = @(0);
    animation.toValue = @(1);
    
    animation.duration = 3;
    
    return animation;
}

@end


@implementation FlashView

+ (Class)layerClass {
    return [CAGradientLayer class];
}

- (CAGradientLayer *)gradientLayer {
    return (CAGradientLayer *)self.layer;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self initialShapeLayer];
        [self initialGradientlayer];
    }
    return self;
}

- (void)initialShapeLayer {
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    layer.lineWidth = 4;
    
    layer.strokeColor = [UIColor yellowColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    
    CGFloat radius = 100;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.center radius:radius startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    layer.path = path.CGPath;
    
    _shapeLayer = layer;
}

- (void)initialGradientlayer {
    self.gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor whiteColor].CGColor,(__bridge id)[UIColor redColor].CGColor];
    
    self.gradientLayer.locations = @[@(-0.2),@(-0.1),@(0)];
    
    self.gradientLayer.startPoint = CGPointMake(0, 0.5);
    self.gradientLayer.endPoint = CGPointMake(1, 0.5);
    
    self.gradientLayer.mask = _shapeLayer;
}

- (void)startAnimation {
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"locations"];
    
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    animation.toValue = @[@(1.0),@(1.1),@(1.2)];
    
    animation.duration = 1;
    animation.repeatCount = INFINITY;
    animation.autoreverses = YES;
    
    [self.gradientLayer addAnimation:animation forKey:nil];
}

@end



