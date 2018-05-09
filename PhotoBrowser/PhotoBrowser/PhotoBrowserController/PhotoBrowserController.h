//
//  PhotoBrowserController.h
//  PhotoBrowser
//
//  Created by ZhiHua Shen on 2018/5/7.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoBrowserItem.h"

@interface PhotoBrowserController : UIViewController

@property (nonatomic, readonly) NSArray <PhotoBrowserItem *> *photoItems;

@property (nonatomic,strong) UIImage *bgImage;

+ (instancetype)browserWith:(NSArray<PhotoBrowserItem *> *)photoItems fromView:(UIView *)fromView;

@end
