//
//  PhotoBrowserItem.h
//  PhotoBrowser
//
//  Created by ZhiHua Shen on 2018/5/7.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoBrowserItem : NSObject

@property (nonatomic, readonly) UIImage *thumbImage;

@property (nonatomic, strong, nullable) UIView *thumbView;

@property (nonatomic, assign) CGSize largeImageSize;

@property (nonatomic, strong) NSURL *largeImageURL;

@end
