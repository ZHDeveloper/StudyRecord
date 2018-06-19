//
//  HomePresenter.h
//  MVP-Demo
//
//  Created by ZhiHua Shen on 2018/6/19.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Presenter.h"
#import "HomeModel.h"
#import "ViewController.h"

@protocol HomeProtocol

- (void)onLoadHomeData:(NSArray<HomeModel *> *)list;

@end

@interface HomePresenter : Presenter<ViewController *>

typedef void(^SuccessBlock)(NSArray *data);
typedef void(^FailuerBlock)(NSArray *error);

// 对外提供方法,使用协议
- (void)getHomeData;

// 使用block
- (void)getHomeDataWithSuccess:(SuccessBlock)success withFailuer:(FailuerBlock)failuer;

@end
