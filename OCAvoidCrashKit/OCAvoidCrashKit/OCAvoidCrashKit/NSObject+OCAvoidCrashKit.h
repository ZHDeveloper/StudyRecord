//
//  NSObject+OCAvoidCrashKit.h
//  OCAvoidCrashKit
//
//  Created by ZhiHua Shen on 2018/6/5.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (OCAvoidCrashKit)

+ (void)instanceMethodExchangeImpl:(SEL)sel1 and:(SEL)sel2;
+ (void)classMethodExchangeImpl:(SEL)sel1 and:(SEL)sel2;

@end
