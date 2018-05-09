//
//  PhotoBrowserItem.m
//  PhotoBrowser
//
//  Created by ZhiHua Shen on 2018/5/7.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "PhotoBrowserItem.h"
#import "UIView+YYAdd.h"
#import "YYWebImage.h"

@implementation PhotoBrowserItem

- (UIImage *)thumbImage {
    if ([_thumbView respondsToSelector:@selector(image)]) {
        return ((UIImageView *)_thumbView).image;
    }
    
    NSString *imageKey = [[YYWebImageManager sharedManager] cacheKeyForURL:_largeImageURL];
    
    UIImage *cacheImg = [[YYWebImageManager sharedManager].cache getImageForKey:imageKey withType:YYImageCacheTypeAll];

    if (cacheImg) {
        return cacheImg;
    }
    
    return [_thumbView snapshotImage];
}

@end
