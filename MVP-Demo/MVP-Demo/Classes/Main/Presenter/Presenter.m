//
//  Presenter.m
//  MVP-Demo
//
//  Created by ZhiHua Shen on 2018/6/19.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "Presenter.h"

@implementation Presenter

- (instancetype)initWithView:(id)view {
    if ([super init]) {
        _view = view;
    }
    return self;
}

- (void)attachView:(id)view {
    _view = view;
}

- (void)detachView {
    _view = nil;
}

@end
