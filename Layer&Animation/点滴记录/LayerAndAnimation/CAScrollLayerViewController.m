//
//  CAScrollLayerViewController.m
//  点滴记录
//
//  Created by ZhiHua Shen on 2018/4/12.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "CAScrollLayerViewController.h"

@interface CAScrollLayerViewController () {
    CAScrollLayer *_sclayer;
}

@property (weak, nonatomic) IBOutlet UIView *ceterView;

@end

@implementation CAScrollLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CAScrollLayer *scrolllayer = [CAScrollLayer layer];
    scrolllayer.frame = self.ceterView.bounds;
    _sclayer = scrolllayer;
    
    scrolllayer.position = self.view.center;
    scrolllayer.scrollMode = kCAScrollVertically;
    
    [self.view.layer addSublayer:scrolllayer];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    
    gradientLayer.colors = @[(__bridge id)[UIColor blueColor].CGColor,(__bridge id)[UIColor yellowColor].CGColor];
    
    gradientLayer.frame = CGRectMake(0, 0, 200, 200);
    [scrolllayer addSublayer:gradientLayer];
    
    UIPanGestureRecognizer *panGest = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestAction:)];
    [self.ceterView addGestureRecognizer:panGest];
}

- (void)panGestAction:(UIPanGestureRecognizer *)pan {

    CGPoint trans = [pan translationInView:self.ceterView];
    CGPoint ori =_sclayer.bounds.origin;
    ori = CGPointMake(ori.x-trans.x, ori.y-trans.y);
    [_sclayer scrollPoint:ori];
    [_sclayer scrollToRect:CGRectMake(-50, -50, 100, 100)];
    NSLog(@"=======%@",NSStringFromCGRect([_sclayer visibleRect]));
    [pan setTranslation:CGPointZero inView:self.ceterView];
}

@end
