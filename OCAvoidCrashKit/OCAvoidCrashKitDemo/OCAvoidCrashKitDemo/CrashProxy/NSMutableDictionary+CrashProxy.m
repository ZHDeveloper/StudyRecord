//
//  NSMutableDictionary+CrashProxy.m
//  OCAvoidCrashKitDemo
//
//  Created by ZhiHua Shen on 2018/6/5.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "NSMutableDictionary+CrashProxy.h"
#import "CrashProxy.h"

@implementation NSMutableDictionary (CrashProxy)

- (void)zh_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    @try {
        [self zh_setObject:anObject forKey:aKey];
    }
    @catch (NSException *exception) {
        [[CrashProxy sharedCrashProxy] attachmentForException:exception];
    }
}

- (void)zh_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    @try {
        [self zh_setObject:obj forKeyedSubscript:key];
    }
    @catch (NSException *exception) {
        [[CrashProxy sharedCrashProxy] attachmentForException:exception];
    }
}

- (id)zh_objectForKeyedSubscript:(id)key {
    @try {
        return [self zh_objectForKeyedSubscript:key];
    }
    @catch (NSException *exception) {
        [[CrashProxy sharedCrashProxy] attachmentForException:exception];
        return nil;
    }
}

- (void)zh_removeObjectForKey:(id)aKey {
    @try {
        [self zh_removeObjectForKey:aKey];
    }
    @catch (NSException *exception) {
        [[CrashProxy sharedCrashProxy] attachmentForException:exception];
    }
}

@end
