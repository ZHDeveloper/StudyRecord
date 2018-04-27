//
//  CAReplicatorLayerViewController.m
//  点滴记录
//
//  Created by ZhiHua Shen on 2018/4/11.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "CAReplicatorLayerViewController.h"

@interface CAReplicatorLayerViewController ()

@end

@implementation CAReplicatorLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self loadingViewDemo];
//    [self radarDemo];
//    [self animationDemo];
    
    TriangleLoadView *view = [[TriangleLoadView alloc] initWithFrame:CGRectMake(0, 0, 50, 50) withStyle:LoaderStyleCation];

    view.center = self.view.center;
    [self.view addSubview:view];

    [view startAnimation];
    
    TriangleLoadView *secondView = [[TriangleLoadView alloc] initWithFrame:CGRectMake(0, 0, 50, 50) withStyle:LoaderStyleTriangle];
    
    secondView.center = CGPointMake(CGRectGetMidX(self.view.bounds), 400);
    [self.view addSubview:secondView];
    
    [secondView startAnimation];
}

- (void)voiceBarDemo {
    
    VoiceBarView *view = [[VoiceBarView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    
    view.itemWidth = 8;
    view.barColor = [UIColor grayColor];
    
    [view startAnimation];
    
    [self.view addSubview:view];
    
    view.center = self.view.center;
}

// 雷达动画
- (void)radarDemo {
    
    CAReplicatorLayer *replayer = [CAReplicatorLayer layer];
    
    replayer.frame = CGRectMake(0, 0, 100, 100);
    [self.view.layer addSublayer:replayer];
    
    replayer.position = self.view.center;
    
    replayer.instanceCount = 8;
    replayer.instanceDelay = 0.8;
    
    CALayer *layer = [CALayer layer];
    layer.frame = replayer.bounds;
    layer.cornerRadius = 50;
    
    layer.backgroundColor = [UIColor redColor].CGColor;
    
    [replayer addSublayer:layer];
    
    CABasicAnimation *fadeAniamtion = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAniamtion.fromValue = @(0.8);
    fadeAniamtion.toValue = @(0);
    
    CABasicAnimation *scalAnimatin = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scalAnimatin.fromValue = @(0.4);
    scalAnimatin.toValue = @(1);
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[fadeAniamtion,scalAnimatin];
    groupAnimation.repeatCount = INFINITY;
    groupAnimation.duration = 2;
    
    [layer addAnimation:groupAnimation forKey:nil];
    
    layer.transform = CATransform3DMakeScale(0.4, 0.4, 0);
    
}

// 加载动画
- (void)loadingViewDemo {
    
    CAReplicatorLayer *replayer = [CAReplicatorLayer layer];
    
    replayer.frame = CGRectMake(0, 0, 100, 100);
    [self.view.layer addSublayer:replayer];
    
    replayer.position = self.view.center;
    
    replayer.backgroundColor = [UIColor grayColor].CGColor;
    replayer.instanceCount = 8;
    CGFloat angle = M_PI * 2.0 / 8;
    replayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
    replayer.instanceDelay = 2/8.0;
    
    CALayer *layer = [CALayer layer];
    
    CGFloat x = (CGRectGetWidth(replayer.frame) - 16) * 0.5;
    CGFloat y = 5;
    CGFloat w = 16;
    CGFloat h = 16;
    layer.frame = CGRectMake(x, y, w, h);
    
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    layer.cornerRadius = 8;
    layer.allowsEdgeAntialiasing = YES;
    
    [replayer addSublayer:layer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    animation.fromValue = @(0.6);
    animation.toValue = @(1);
    
//    animation.autoreverses = YES;
    animation.repeatCount = INFINITY;
    
    animation.duration = 2;
    
    [layer addAnimation:animation forKey:nil];
}

@end

@implementation VoiceBarView

+ (Class)layerClass {
    return [CAReplicatorLayer class];
}

- (CAReplicatorLayer *)repLayer {
    return (CAReplicatorLayer *)self.layer;
}

- (void)setInsDelay:(CGFloat)insDelay {
    _insDelay = insDelay;
    [self redispaly];
}

- (void)setItemWidth:(CGFloat)itemWidth {
    _itemWidth = itemWidth;
    [self redispaly];
}

- (void)setRepCount:(CGFloat)repCount {
    _repCount = repCount;
    [self redispaly];
}

- (void)setBarColor:(UIColor *)barColor {
    _barColor = barColor;
    _barLayer.backgroundColor = barColor.CGColor;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        
        self.itemWidth = 10;
        self.repCount = 3;
        self.insDelay = 0.2;
        
        CALayer *layer = [CALayer layer];
        _barLayer = layer;
        
        layer.anchorPoint = CGPointMake(0.5, 1);
        
        layer.backgroundColor = [UIColor grayColor].CGColor;
        
        [self redispaly];
    }
    return self;
}

- (void)redispaly {
    
    CGFloat margin = (self.frame.size.width - self.repCount * self.itemWidth)/(self.repCount+1);
    
    _barLayer.frame = CGRectMake(margin, 0, self.itemWidth, CGRectGetHeight(self.bounds));
    
    self.repLayer.instanceCount = self.repCount;
    self.repLayer.instanceTransform = CATransform3DMakeTranslation(margin+self.itemWidth, 0, 0);
    self.repLayer.instanceDelay = self.insDelay;
    
    [self.repLayer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [self.repLayer addSublayer:_barLayer];
}

- (void)startAnimation {
    
    if (!_barLayer.superlayer) { return; }
    
    [_barLayer removeAllAnimations];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    
    animation.fromValue = @(0.3);
    animation.toValue = @(1);
    
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    animation.duration = 0.5;
    animation.repeatCount = INFINITY;
    animation.autoreverses = YES;
    
    [_barLayer addAnimation:animation forKey:nil];
}

@end

@implementation TriangleLoadView

+ (Class)layerClass {
    return [CAReplicatorLayer class];
}

- (CAReplicatorLayer *)repLayer {
    return (CAReplicatorLayer *)self.layer;
}

- (instancetype)initWithFrame:(CGRect)frame withStyle:(LoaderStyle)style {
    if ([super initWithFrame:frame]) {
        self.style = style;
        _dotRadius = 4;
        _margin = 16;
        if (style==LoaderStyleCation) {
            self.repLayer.instanceDelay = 3.0/3;
            self.repLayer.instanceRedOffset = -0.4;
            self.repLayer.instanceBlueOffset = -0.2;
        }
        else {
            self.repLayer.instanceDelay = 2.0/3;
        }
        self.repLayer.instanceCount = 3;
        [self initialDotLayer];
        [self redispaly];
    }
    return self;
}

- (void)initialDotLayer {
    CALayer *layer = [CALayer layer];
    _dotlayer = layer;
    layer.backgroundColor = [UIColor blueColor].CGColor;
    layer.cornerRadius = self.dotRadius;
    layer.contentsScale = [UIScreen mainScreen].scale;
    layer.allowsEdgeAntialiasing = YES;
    [self.repLayer addSublayer:layer];
}

- (void)redispaly {
    switch (self.style) {
        case LoaderStyleTriangle:
            //计算初始点的位置
            _dotlayer.frame = CGRectMake((CGRectGetWidth(self.bounds) - self.dotRadius * 2) / 2.0, CGRectGetHeight(self.bounds) * 0.3, self.dotRadius*2, self.dotRadius * 2);
            break;
        case LoaderStyleCation:
        {
            _dotlayer.frame = CGRectMake(0, 0, self.dotRadius*2, self.dotRadius * 2);
            CGFloat centerX = CGRectGetMidX(self.bounds);
            CGFloat centerY = CGRectGetMidY(self.bounds);
            _dotlayer.position = CGPointMake(centerX-self.margin, centerY);
        }
        default:
            break;
    }
}

- (void)startAnimation {
    
    [_dotlayer removeAllAnimations];
    
    switch (self.style) {
        case LoaderStyleTriangle:
        {
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
            
            animation.path = [self trianglePath].CGPath;
            
            animation.duration = 2;
            animation.repeatCount = INFINITY;
            
            [_dotlayer addAnimation:animation forKey:nil];
        }
            break;
        case LoaderStyleCation:
        {
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
            
            animation.path = [self cationPath].CGPath;
            
            animation.duration = 3;
            animation.repeatCount = INFINITY;
            
            [_dotlayer addAnimation:animation forKey:nil];
        }
            break;
        default:
            break;
    }
    
}

- (UIBezierPath *)trianglePath {
    
    CGFloat topRatio = 0.3;
    CGFloat ratio = 1 - topRatio * 2;
    
    CGFloat kTop = CGRectGetWidth(self.bounds) * topRatio;
    CGFloat kHeight = CGRectGetWidth(self.bounds) * ratio;
    
    UIBezierPath *tPath = [UIBezierPath bezierPath];
    
    [tPath moveToPoint:CGPointMake(CGRectGetWidth(self.bounds)/2.0, kTop)];
    
    [tPath addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds)/2.0 + sqrt(kHeight * kHeight / 3.0), kTop + kHeight)];
    [tPath addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds)/2.0 - sqrt(kHeight * kHeight / 3.0), kTop + kHeight)];
    
    [tPath closePath];

    return tPath;
}

- (UIBezierPath *)cationPath {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGFloat centerX = CGRectGetMidX(self.bounds);
    CGFloat centerY = CGRectGetMidY(self.bounds);
    
    CGFloat radius = self.margin*0.5;
    CGFloat offset = 25;
    
    [path moveToPoint:CGPointMake(centerX-self.margin, centerY)];
    [path addCurveToPoint:CGPointMake(centerX+self.margin, centerY) controlPoint1:CGPointMake(centerX-radius, centerY-offset) controlPoint2:CGPointMake(centerX+radius, centerY+offset)];
    
    [path moveToPoint:CGPointMake(centerX+self.margin, centerY)];
    [path addCurveToPoint:CGPointMake(centerX-self.margin, centerY) controlPoint1:CGPointMake(centerX+radius, centerY-offset) controlPoint2:CGPointMake(centerX-radius, centerY+offset)];
    
    return path;
}

@end

