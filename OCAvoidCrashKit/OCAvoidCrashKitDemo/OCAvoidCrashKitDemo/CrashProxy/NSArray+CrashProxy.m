//
//  NSArray+CrashProxy.m
//  OCAvoidCrashKitDemo
//
//  Created by ZhiHua Shen on 2018/6/5.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "NSArray+CrashProxy.h"
#import "CrashProxy.h"

@implementation NSArray (CrashProxy)

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

- (NSArray *)zh_objectsAtIndexes:(NSIndexSet *)indexes {
    @try {
        return [self zh_objectsAtIndexes:indexes];
    }
    @catch (NSException *exception) {
        [[CrashProxy sharedCrashProxy] attachmentForException:exception];
        return nil;
    }
}

@end
