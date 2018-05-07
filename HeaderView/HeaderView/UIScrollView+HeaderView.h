//
//  UIScrollView+HeaderView.h
//  HeaderView
//
//  Created by ZhiHua Shen on 2018/5/7.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (HeaderScaleView)

// 可以添加自定义view
@property (nonatomic,strong,readonly) UIView *headerView;

@property (nonatomic,strong) UIImage *scaleImage;

@property (nonatomic,assign) CGFloat scaleImageHeight;

@end

@interface UIResponder (Ext)

- (UIViewController *)parentViewController;

@end

@interface UIView (CS_Frame)

/// 视图原点
@property (nonatomic) CGPoint zh_viewOrigin;
/// 视图尺寸
@property (nonatomic) CGSize zh_viewSize;

#pragma mark - Frame Origin
/// frame 原点 x 值
@property (nonatomic) CGFloat zh_x;
/// frame 原点 y 值
@property (nonatomic) CGFloat zh_y;

#pragma mark - Frame Size
/// frame 尺寸 width
@property (nonatomic) CGFloat zh_width;
/// frame 尺寸 height
@property (nonatomic) CGFloat zh_height;

@end
