//
//  PhotoBrowserCell.h
//  PhotoBrowser
//
//  Created by ZhiHua Shen on 2018/5/9.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoBrowserItem.h"

@interface PhotoBrowserCell : UIScrollView<UIScrollViewDelegate>
@property (nonatomic, strong) UIView *imageContainerView;
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, assign) BOOL showProgress;

@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) PhotoBrowserItem *item;
@property (nonatomic, readonly) BOOL itemDidLoad;

- (void)resizeSubviewSize;

@end
