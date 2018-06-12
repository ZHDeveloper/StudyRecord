//
//  NSObject+CrashProxy.m
//  CrashProxy
//
//  Created by ZhiHua Shen on 2018/6/5.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "NSObject+CrashProxy.h"
#import "CrashProxy.h"

@implementation NSObject (CrashProxy)

- (void)zh_setValue:(id)value forKey:(NSString *)key {
    @try {
        [self zh_setValue:value forKey:key];
    }
    @catch (NSException *exception) {
        [[CrashProxy sharedCrashProxy] attachmentForException:exception];
    }
}

- (void)zh_setValue:(id)value forKeyPath:(NSString *)keyPath {
    @try {
        [self zh_setValue:value forKeyPath:keyPath];
    }
    @catch (NSException *exception) {
        [[CrashProxy sharedCrashProxy] attachmentForException:exception];
    }
}

- (void)zh_setValue:(id)value forUndefinedKey:(NSString *)key {
    @try {
        [self zh_setValue:value forUndefinedKey:key];
    }
    @catch (NSException *exception) {
        [[CrashProxy sharedCrashProxy] attachmentForException:exception];
    }
}

- (NSMethodSignature *)zh_methodSignatureForSelector:(SEL)aSelector {
    return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
}

- (void)zh_forwardInvocation:(NSInvocation *)anInvocation {
    NSString *message = [NSString stringWithFormat:@"-[%@ %@]: unrecognized selector sent to instance %p",[anInvocation.target class],NSStringFromSelector(anInvocation.selector),anInvocation.target];    
    NSException *exception = [[NSException alloc] initWithName:@"UnrecognizedSelectorException" reason:message userInfo:nil];
    [[CrashProxy sharedCrashProxy] attachmentForException:exception];
}

+ (NSMethodSignature *)zh_methodSignatureForSelector:(SEL)aSelector {
    return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
}

+ (void)zh_forwardInvocation:(NSInvocation *)anInvocation {
    NSString *message = [NSString stringWithFormat:@"+[%@ %@]: unrecognized selector sent to instance %p",[anInvocation.target class],NSStringFromSelector(anInvocation.selector),anInvocation.target];
    NSException *exception = [[NSException alloc] initWithName:@"UnrecognizedSelectorException" reason:message userInfo:nil];
    [[CrashProxy sharedCrashProxy] attachmentForException:exception];
}

@end
