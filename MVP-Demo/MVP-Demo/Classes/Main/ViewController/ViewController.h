//
//  ViewController.h
//  MVP-Demo
//
//  Created by ZhiHua Shen on 2018/6/19.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeModel;
@interface ViewController : UIViewController

- (void)onLoadHomeData:(NSArray<HomeModel *> *)list;

@end

