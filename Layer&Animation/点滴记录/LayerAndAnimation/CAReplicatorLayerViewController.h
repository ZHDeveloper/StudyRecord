//
//  CAReplicatorLayerViewController.h
//  点滴记录
//
//  Created by ZhiHua Shen on 2018/4/11.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CAReplicatorLayerViewController : UIViewController


@end


@interface VoiceBarView: UIView {
    CALayer *_barLayer;
}

@property (nonatomic,readonly) CAReplicatorLayer *repLayer;

// 默认10
@property (nonatomic,assign) CGFloat itemWidth;
// 默认3
@property (nonatomic,assign) CGFloat repCount;
// 默认0.2
@property (nonatomic,assign) CGFloat insDelay;
// 默认gray
@property (nonatomic,strong) UIColor *barColor;

- (void)redispaly;

- (void)startAnimation;

@end

typedef NS_ENUM(NSUInteger, LoaderStyle) {
    LoaderStyleTriangle = 1,
    LoaderStyleCation = 1<<1,
    LoaderStyleShip = 1<<2,
};

@interface TriangleLoadView: UIView {
    CALayer *_dotlayer;
}

@property (nonatomic,readonly) CAReplicatorLayer *repLayer;

@property (nonatomic,assign,readonly) CGFloat dotRadius;

@property (nonatomic,assign,readonly) CGFloat margin;

@property (nonatomic,assign) LoaderStyle style;

- (instancetype)initWithFrame:(CGRect)frame withStyle:(LoaderStyle)style;

- (void)startAnimation;

@end
