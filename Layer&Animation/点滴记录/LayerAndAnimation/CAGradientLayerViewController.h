//
//  CAGradientLayerViewController.h
//  点滴记录
//
//  Created by ZhiHua Shen on 2018/4/10.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CAGradientLayerViewController : UIViewController

@end

@interface ProgressView: UIView {
    CAShapeLayer *_progressLayer;
    CABasicAnimation *_animation;
}

@property (nonatomic,readonly) CAGradientLayer *gradientLayer;

- (void)startAnimation;

@end

@interface FlashView: UIView {
    CAShapeLayer *_shapeLayer;
}

@property (nonatomic,readonly) CAGradientLayer *gradientLayer;

- (void)startAnimation;

@end

