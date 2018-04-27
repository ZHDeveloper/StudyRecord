//
//  CAEmitterLayerViewController.m
//  点滴记录
//
//  Created by ZhiHua Shen on 2018/4/14.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "CAEmitterLayerViewController.h"

@interface CAEmitterLayerViewController ()

@property (weak, nonatomic) IBOutlet EmitterButton *button;

@end

@implementation CAEmitterLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)praiseButton:(EmitterButton *)sender {
    
    sender.selected = !sender.isSelected;
    
}

@end

@implementation EmitterButton

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self.layer addSublayer:self.emitterLayer];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.layer addSublayer:self.emitterLayer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.emitterLayer.frame = self.bounds;
    self.emitterLayer.emitterPosition = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    if (selected) {
        [self explosionAnimation];
    }
    
    [self scaleAnimation];
}

- (void)scaleAnimation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@1.5 ,@0.8, @1.0,@1.2,@1.0];
    animation.duration = 0.5;
    animation.calculationMode = kCAAnimationCubic;
    [self.layer addAnimation:animation forKey:@"transform.scale"];
}

- (void)explosionAnimation {
    self.emitterLayer.beginTime = CACurrentMediaTime();
    
    [self.emitterLayer setValue:@2500 forKeyPath:@"emitterCells.explosion.birthRate"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.emitterLayer setValue:@0 forKeyPath:@"emitterCells.explosion.birthRate"];
    });
    
}

- (CAEmitterLayer *)emitterLayer {
    if (!_emitterLayer) {
        _emitterLayer = [CAEmitterLayer layer];
        _emitterLayer.name = @"emitterLayer";
        _emitterLayer.emitterShape = kCAEmitterLayerCircle;
        _emitterLayer.emitterMode = kCAEmitterLayerOutline;
        _emitterLayer.emitterSize = CGSizeMake(10, 0);
        _emitterLayer.emitterCells = @[self.explosionCell];
        _emitterLayer.renderMode = kCAEmitterLayerOldestFirst;
        _emitterLayer.masksToBounds = NO;
    }
    return _emitterLayer;
}

- (CAEmitterCell *)explosionCell {
    if (!_explosionCell) {
        CAEmitterCell *explosionCell = [CAEmitterCell emitterCell];
        explosionCell.name = @"explosion";
        explosionCell.alphaRange = 0.10;
        explosionCell.alphaSpeed = -1.0;
        explosionCell.lifetime = 0.7;
        explosionCell.lifetimeRange = 0.3;
        explosionCell.birthRate = 0;
        explosionCell.velocity = 40.00;
        explosionCell.velocityRange = 10.00;
        explosionCell.scale = 0.04;
        explosionCell.scaleRange = 0.02;
        explosionCell.contents = (id)[UIImage imageNamed:@"sparkle"].CGImage;
        _explosionCell = explosionCell;
    }
    return _explosionCell;
}

@end

@implementation HeartButton

- (CAEmitterLayer *)emitterLayer {
    if (!_emitterLayer) {
        CAEmitterLayer *layer = [CAEmitterLayer layer];
        _emitterLayer = layer;
    }
    return _emitterLayer;
}

@end

