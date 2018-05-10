//
//  UIView+PhotoBrowser.h
//  PhotoBrowser
//
//  Created by ZhiHua Shen on 2018/5/10.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (PhotoBrowser)

@property (nonatomic) CGFloat left;

@property (nonatomic) CGFloat top;

@property (nonatomic) CGFloat right;

@property (nonatomic) CGFloat bottom;

@property (nonatomic) CGFloat width;

@property (nonatomic) CGFloat height;

@property (nonatomic) CGFloat centerX;

@property (nonatomic) CGFloat centerY;

@property (nonatomic) CGPoint origin;

@property (nonatomic) CGSize  size;

@property (nullable, nonatomic, readonly) UIViewController *viewController;

- (UIImage * _Nonnull )snapshotImage;
- (UIImage *_Nonnull)snapshotImageAfterScreenUpdates:(BOOL)afterUpdates;

@end
