//
//  Person.h
//  __attribute__
//
//  Created by ZhiHua Shen on 2018/6/6.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic,copy) NSString *name;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)initWith:(NSString *)name NS_DESIGNATED_INITIALIZER;

- (void)work __attribute__((deprecated("请使用doWork")));
- (void)doWork;

- (void)run NS_DEPRECATED_IOS(8.0, 10.0, "不推荐使用方法");
- (void)doRun CF_DEPRECATED_IOS(7.0,10.0, "不推荐使用方法");

- (void)sleep __attribute__((objc_requires_super));

@end

/// 相当于final,又称太监类，不能被集成。
__attribute__((objc_subclassing_restricted))
__attribute__((objc_runtime_name("HMStudent")))
@interface Student: Person

- (void)sleep __attribute__((noreturn));

@end

@interface HMStudent: Person

@end


