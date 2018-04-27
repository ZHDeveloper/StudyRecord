//
//  CAShapeLayerViewController.m
//  点滴记录
//
//  Created by ZhiHua Shen on 2018/4/10.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "CAShapeLayerViewController.h"

@interface CAShapeLayerViewController () {
    CAShapeLayer *_shapeLayer;
}

@end

@implementation CAShapeLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _shapeLayer = [[CAShapeLayer alloc] init];
    _shapeLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:_shapeLayer];
    _shapeLayer.strokeColor = [UIColor greenColor].CGColor;
    _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    _shapeLayer.lineWidth = 4;
    
    _shapeLayer.path = [self twoBezierPath].CGPath;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_shapeLayer addAnimation:[self keyframeAnimation] forKey:@"path"];
}

#pragma mark Path
- (UIBezierPath *)oneBezierPath {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(0, 200)];
    
    [path addQuadCurveToPoint:CGPointMake(SCREEN_WIDTH, 200) controlPoint:CGPointMake(SCREEN_WIDTH * 0.5, 300)];
    
    return path;
}



- (UIBezierPath *)twoBezierPath {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(0, 200)];
    
    [path addCurveToPoint:CGPointMake(SCREEN_WIDTH, 200) controlPoint1:CGPointMake(SCREEN_WIDTH*0.25, 100) controlPoint2:CGPointMake(SCREEN_WIDTH*0.75, 300)];
    
    [path moveToPoint:CGPointMake(SCREEN_WIDTH, 200)];
    [path addCurveToPoint:CGPointMake(0, 200) controlPoint1:CGPointMake(SCREEN_WIDTH*0.75, 100) controlPoint2:CGPointMake(SCREEN_WIDTH*0.25, 300)];
    
    return path;
}

- (UIBezierPath *)linePath {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(SCREEN_WIDTH*0.5-20, SCREENH_HEIGHT*0.5-20)];
    [path addLineToPoint:CGPointMake(SCREEN_WIDTH*0.5+20, SCREENH_HEIGHT*0.5-20)];
    
    [path moveToPoint:CGPointMake(SCREEN_WIDTH*0.5-20, SCREENH_HEIGHT*0.5)];
    [path addLineToPoint:CGPointMake(SCREEN_WIDTH*0.5+20, SCREENH_HEIGHT*0.5)];

    [path moveToPoint:CGPointMake(SCREEN_WIDTH*0.5-20, SCREENH_HEIGHT*0.5+20)];
    [path addLineToPoint:CGPointMake(SCREEN_WIDTH*0.5+20, SCREENH_HEIGHT*0.5+20)];
    
    return path;
}

- (UIBezierPath *)forkPath {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(SCREEN_WIDTH*0.5-20, SCREENH_HEIGHT*0.5-20)];
    [path addLineToPoint:CGPointMake(SCREEN_WIDTH*0.5+20, SCREENH_HEIGHT*0.5+20)];
    
    [path moveToPoint:CGPointMake(SCREEN_WIDTH*0.5+20, SCREENH_HEIGHT*0.5-20)];
    [path addLineToPoint:CGPointMake(SCREEN_WIDTH*0.5-20, SCREENH_HEIGHT*0.5+20)];
    
    return path;
}

- (UIBezierPath *)circlePath {
    
    CGFloat x = SCREEN_WIDTH * 0.5 - 100;
    CGFloat y = SCREENH_HEIGHT * 0.5 - 100;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(x, y, 200, 200)];
    
    return path;
}

#pragma mark -- Animation
- (CABasicAnimation *)pathAnimation {
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    animation.duration = 1;
    
    animation.toValue = (__bridge id _Nullable)([self forkPath].CGPath);
    
    return animation;
}

- (CABasicAnimation *)strokeAnimation {
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    animation.duration = 3;
    
    animation.fromValue = @(0);
    animation.toValue = @(1);
    
    return animation;
}

// 关键帧动画
- (CAKeyframeAnimation *)keyframeAnimation {
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    
    animation.duration = 2;
    
    animation.values = @[(__bridge id)[self oneBezierPath].CGPath,(__bridge id)[self linePath].CGPath,(__bridge id)[self forkPath].CGPath,(__bridge id)[self twoBezierPath].CGPath];
    
    return animation;
}

- (CABasicAnimation *)positionAnimation {
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH, SCREENH_HEIGHT)];
    
    animation.duration = 1;
    
    return animation;
}

- (CAAnimationGroup *)groupAnimation {
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[[self keyframeAnimation],[self positionAnimation]];
    
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    
    group.duration = 4;
    
    return group;
}

@end
