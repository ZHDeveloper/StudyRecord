//
//  NSObject+OCAvoidCrashKit.m
//  OCAvoidCrashKit
//
//  Created by ZhiHua Shen on 2018/6/5.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "NSObject+OCAvoidCrashKit.h"
#import <objc/runtime.h>

@implementation NSObject (OCAvoidCrashKit)

+ (void)load {
    [self instanceMethodExchangeImpl:@selector(methodSignatureForSelector:) and:@selector(zh_methodSignatureForSelector:)];
    [self instanceMethodExchangeImpl:@selector(forwardInvocation:) and:@selector(zh_forwardInvocation:)];
    
    [self classMethodExchangeImpl:@selector(methodSignatureForSelector:) and:@selector(zh_methodSignatureForSelector:)];
    [self classMethodExchangeImpl:@selector(forwardInvocation:) and:@selector(zh_forwardInvocation:)];
}

+ (void)instanceMethodExchangeImpl:(SEL)sel1 and:(SEL)sel2 {
    Method method1 = class_getInstanceMethod(self, sel1);
    Method method2 = class_getInstanceMethod(self, sel2);
    method_exchangeImplementations(method1, method2);
}

+ (void)classMethodExchangeImpl:(SEL)sel1 and:(SEL)sel2 {
    Method method1 = class_getClassMethod(self, sel1);
    Method method2 = class_getClassMethod(self, sel2);
    method_exchangeImplementations(method1, method2);
}

- (NSMethodSignature *)zh_methodSignatureForSelector:(SEL)aSelector {
    return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
}

- (void)zh_forwardInvocation:(NSInvocation *)anInvocation {
    NSString *message = [NSString stringWithFormat:@"-[%@ %@]: unrecognized selector sent to instance %p",[anInvocation.target class],NSStringFromSelector(anInvocation.selector),anInvocation.target];
    NSLog(@"%@",message);
    NSArray<NSString *> *bt = [NSThread callStackSymbols];
    NSLog(@"%@",bt);
}

+ (NSMethodSignature *)zh_methodSignatureForSelector:(SEL)aSelector {
    return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
}

+ (void)zh_forwardInvocation:(NSInvocation *)anInvocation {
    NSString *message = [NSString stringWithFormat:@"+[%@ %@]: unrecognized selector sent to instance %p",[anInvocation.target class],NSStringFromSelector(anInvocation.selector),anInvocation.target];
    NSLog(@"%@",message);
    NSArray<NSString *> *bt = [NSThread callStackSymbols];
    NSLog(@"%@",bt);
}

@end
