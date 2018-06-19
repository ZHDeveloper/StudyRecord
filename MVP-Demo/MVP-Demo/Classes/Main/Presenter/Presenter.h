//
//  Presenter.h
//  MVP-Demo
//
//  Created by ZhiHua Shen on 2018/6/19.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Presenter<ViewProtocol> : NSObject

@property (nonatomic, weak, readonly) ViewProtocol view;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

/// 初始化绑定视图
- (instancetype)initWithView:(ViewProtocol)view NS_DESIGNATED_INITIALIZER;

/// 绑定view
- (void) attachView:(ViewProtocol)view ;

/// 解绑view
- (void)detachView;

@end
