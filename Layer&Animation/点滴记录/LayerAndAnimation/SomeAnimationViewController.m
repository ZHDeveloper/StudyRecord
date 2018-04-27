//
//  SomeAnimationViewController.m
//  点滴记录
//
//  Created by ZhiHua Shen on 2018/4/18.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "SomeAnimationViewController.h"

@interface SomeAnimationViewController () {
    CAGradientLayer *_gradientLayer;
}

@property (weak, nonatomic) IBOutlet UIImageView *topImageV;

@property (weak, nonatomic) IBOutlet UIImageView *bottomImageV;

@property (weak, nonatomic) IBOutlet UIView *gestView;


@end

@implementation SomeAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topImageV.layer.contentsRect = CGRectMake(0, 0, 1, 0.5);
    self.topImageV.layer.anchorPoint = CGPointMake(0.5, 1);
    self.bottomImageV.layer.contentsRect = CGRectMake(0, 0.5, 1, 0.5);
    self.bottomImageV.layer.anchorPoint = CGPointMake(0.5, 1);
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gestAction:)];
    [self.gestView addGestureRecognizer:pan];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    _gradientLayer = gradientLayer;
    gradientLayer.frame = self.bottomImageV.bounds;
    
    gradientLayer.colors = @[(id)[UIColor clearColor].CGColor,(id)[UIColor blackColor].CGColor];
    
    gradientLayer.opacity = 0;
    
    [self.bottomImageV.layer addSublayer:gradientLayer];
}

- (void)gestAction:(UIPanGestureRecognizer *)gest {
    
    //获取当前手势的偏移量
    CGPoint tranP = [gest translationInView:self.gestView];
    
    //调整阴影
    _gradientLayer.opacity = tranP.y / 200.0;
    
    //获取角度
    CGFloat angle = tranP.y * M_PI_2 / 200.0;
    
    CATransform3D transform = CATransform3DIdentity;
    
    transform.m34 = -1 / 300;
    
    transform = CATransform3DRotate(transform, angle, 1, 0, 0);
    
    self.topImageV.layer.transform = transform;

    if (gest.state != UIGestureRecognizerStateEnded) {
        return;
    }
    
    _gradientLayer.opacity = 0;
    
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.topImageV.layer.transform = CATransform3DIdentity;
    } completion:nil];
    
}



@end
