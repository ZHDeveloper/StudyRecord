//
//  NSMutableArray+CrashProxy.m
//  CrashProxyDemo
//
//  Created by ZhiHua Shen on 2018/6/5.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "NSMutableArray+CrashProxy.h"
#import "CrashProxy.h"

@implementation NSMutableArray (CrashProxy)

- (void)zh_insertObject:(id)anObject atIndex:(NSUInteger)index {
    @try {
        [self zh_insertObject:anObject atIndex:index];
    }
    @catch (NSException *exception) {
        [[CrashProxy sharedCrashProxy] attachmentForException:exception];
    }
}

- (void)zh_setObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    @try {
        [self zh_setObject:obj atIndexedSubscript:idx];
    }
    @catch (NSException *exception) {
        [[CrashProxy sharedCrashProxy] attachmentForException:exception];
    }
}

- (void)zh_removeObjectAtIndex:(NSUInteger)index {
    @try {
        [self zh_removeObjectAtIndex:index];
    }
    @catch (NSException *exception) {
        [[CrashProxy sharedCrashProxy] attachmentForException:exception];
    }
}

- (id)zh_objectAtIndexedSubscript:(NSUInteger)idx {
    if ( idx >= self.count) {
        NSString *message = [NSString stringWithFormat:@"%s:index %zd beyond bounds [0 .. %lu]", __func__, idx, (unsigned long)self.count];
        NSException *exception = [NSException exceptionWithName:@"BeyondBoundsException" reason:message userInfo:nil];
        [[CrashProxy sharedCrashProxy] attachmentForException:exception];
        return nil;
    }
    return [self zh_objectAtIndexedSubscript:idx];
}

- (id)zh_objectAtIndex:(NSUInteger)index {
    if ( index >= self.count ) {
        NSString *message = [NSString stringWithFormat:@"%s:index %zd beyond bounds [0 .. %lu]", __func__, index, (unsigned long)self.count];
        NSException *exception = [NSException exceptionWithName:@"BeyondBoundsException" reason:message userInfo:nil];
        [[CrashProxy sharedCrashProxy] attachmentForException:exception];
        return nil;
    }
    return [self zh_objectAtIndex:index];
}

@end
