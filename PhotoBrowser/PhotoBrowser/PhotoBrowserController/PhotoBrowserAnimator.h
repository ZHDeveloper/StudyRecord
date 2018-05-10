//
//  PhotoBrowserAnimator.h
//  PhotoBrowser
//
//  Created by ZhiHua Shen on 2018/5/7.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhotoBrowserItem;
@interface PhotoBrowserAnimator : NSObject <UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>

@property (nonatomic,strong) PhotoBrowserItem *presentItem;

- (instancetype)initWith:(PhotoBrowserItem *)presentItem;

@end
