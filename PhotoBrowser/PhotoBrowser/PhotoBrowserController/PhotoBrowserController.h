//
//  PhotoBrowserController.h
//  PhotoBrowser
//
//  Created by ZhiHua Shen on 2018/5/7.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoBrowserController : UIViewController

@property (nonatomic,strong) UIImage *bgImage;

- (instancetype)initWithItems:(NSArray *)photoItems fromView:(UIView *)fromView;

@end
