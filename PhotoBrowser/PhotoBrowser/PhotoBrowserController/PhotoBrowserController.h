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

@property (nonatomic,assign) NSInteger currentIndex;

@property (nonatomic, strong) NSArray <PhotoBrowserItem *> *photoItems;

@property (nonatomic,strong) UIImage *bgImage;

+ (instancetype)browserWithSelectedIndex:(NSInteger)index phothItems:(NSArray<PhotoBrowserItem *> *)photoItems fromView:(UIView *)fromView;

@end
