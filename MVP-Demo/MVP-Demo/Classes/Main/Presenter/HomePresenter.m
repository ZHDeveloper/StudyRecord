//
//  HomePresenter.m
//  MVP-Demo
//
//  Created by ZhiHua Shen on 2018/6/19.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "HomePresenter.h"

@implementation HomePresenter

// 方法实现的逻辑
- (void)getHomeData {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSMutableArray *array = [NSMutableArray array];
        
        for (int i = 0; i<10; i++) {
            HomeModel *model = [HomeModel new];
            model.name = [NSString stringWithFormat:@"%d",i];
            [array addObject:model];
        }
        
        [self.view onLoadHomeData:array];
    });
}

- (void)getHomeDataWithSuccess:(SuccessBlock)success withFailuer:(FailuerBlock)failuer {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSMutableArray *array = [NSMutableArray array];
        
        for (int i = 0; i<10; i++) {
            HomeModel *model = [HomeModel new];
            model.name = [NSString stringWithFormat:@"%d",i];
            [array addObject:model];
        }

        if (success) {
            success(array);
        }
        
    });
    
}

- (void)dealloc {
    NSLog(@"HomePresenter dealloc");
}

@end
