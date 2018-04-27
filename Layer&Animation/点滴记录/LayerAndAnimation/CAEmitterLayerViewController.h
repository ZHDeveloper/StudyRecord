//
//  CAEmitterLayerViewController.h
//  点滴记录
//
//  Created by ZhiHua Shen on 2018/4/14.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CAEmitterLayerViewController : UIViewController

@end

@interface EmitterButton: UIButton

@property (nonatomic,strong) CAEmitterLayer *emitterLayer;
@property (nonatomic,strong) CAEmitterCell *explosionCell;

- (void)scaleAnimation;
- (void)explosionAnimation;

@end

@interface HeartButton: UIButton

@property (nonatomic,strong) CAEmitterLayer *emitterLayer;
@property (nonatomic,strong) CAEmitterCell *explosionCell;

@end
