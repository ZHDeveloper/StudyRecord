//
//  NSDictionary+CrashProxy.m
//  OCAvoidCrashKitDemo
//
//  Created by ZhiHua Shen on 2018/6/5.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "NSDictionary+CrashProxy.h"
#import "CrashProxy.h"

@implementation NSDictionary (CrashProxy)

+ (instancetype)zh_dictionaryWithObjects:(id  _Nonnull const [])objects forKeys:(id<NSCopying>  _Nonnull const [])keys count:(NSUInteger)cnt {
    @try {
        return [self zh_dictionaryWithObjects:objects forKeys:keys count:cnt];
    }
    @catch (NSException *exception) {
        [[CrashProxy sharedCrashProxy] attachmentForException:exception];
        return nil;
    }
}

@end
