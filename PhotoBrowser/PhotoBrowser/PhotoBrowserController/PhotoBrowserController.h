//
//  PhotoBrowserController.h
//  PhotoBrowser
//
//  Created by ZhiHua Shen on 2018/5/7.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhotoBrowserCell,PhotoBrowserItem;
@interface PhotoBrowserController : UIViewController

@property (nonatomic,assign) NSInteger currentIndex;

@property (nonatomic, strong) NSArray <PhotoBrowserItem *> *photoItems;

@property (nonatomic,strong) UIImage *bgImage;

@property (nonatomic,readonly) PhotoBrowserCell *visualCell;

+ (instancetype)browserWithSelectedIndex:(NSInteger)index phothItems:(NSArray<PhotoBrowserItem *> *)photoItems;

@end
