//
//  Person.m
//  __attribute__
//
//  Created by ZhiHua Shen on 2018/6/6.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "Person.h"

@implementation Person

- (instancetype)initWith:(NSString *)name {
    if ([super init]) {
        self.name = name;
    }
    return self;
}

- (void)work {
    
}

- (void)doWork {
    
}

- (void)run {
    
}

- (void)doRun {
    
}

@end

@implementation Student

- (void)sleep {
    [super sleep];
    
}

@end

@implementation HMStudent

@end
