//
//  CrashProxy.m
//  CrashProxyDemo
//
//  Created by ZhiHua Shen on 2018/6/5.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "CrashProxy.h"
#include <libkern/OSAtomic.h>
#include <execinfo.h>

const void *kEnableAvoidCrash = &kEnableAvoidCrash;
volatile int32_t UncaughtExceptionCount = 0;
//最大能够处理的异常个数
volatile int32_t UncaughtExceptionMaximum = 20;

@implementation CrashProxy

singleton_implementation(CrashProxy)

void UncaughtExceptionHandler(NSException *exception) {
    [[CrashProxy sharedCrashProxy] attachmentForException:exception];
}

void HandleException(int signo)
{
    int32_t exceptionCount = OSAtomicIncrement32(&UncaughtExceptionCount);
    if (exceptionCount > UncaughtExceptionMaximum)
    {
        return;
    }
    NSMutableDictionary *userInfo =[NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:signo] forKey:@"signal"];
    
    //创建一个OC异常对象
    NSException *ex = [NSException exceptionWithName:@"SignalExceptionName" reason:[NSString stringWithFormat:@"Signal %d was raised.\n",signo] userInfo:userInfo];
    
    //处理异常消息
    NSLog(@"%@",ex);
}

void SignalExceptionHandler(int signal) {
    NSMutableString *mstr = [[NSMutableString alloc] init];
    [mstr appendString:@"Stack:\n"];
    void* callstack[128];
    int i, frames = backtrace(callstack, 128);
    char** strs = backtrace_symbols(callstack, frames);
    for (i = 0; i <frames; ++i) {
        [mstr appendFormat:@"%s\n", strs[i]];
    }
    ZHLog(@"%@",mstr);
}

+ (void)RegisterSignalHandler
{
    //注册程序由于abort()函数调用发生的程序中止信号
    signal(SIGABRT, HandleException);
    
    //注册程序由于非法指令产生的程序中止信号
    signal(SIGILL, HandleException);
    
    //注册程序由于无效内存的引用导致的程序中止信号
    signal(SIGSEGV, HandleException);
    
    //注册程序由于浮点数异常导致的程序中止信号
    signal(SIGFPE, HandleException);
    
    //注册程序由于内存地址未对齐导致的程序中止信号
    signal(SIGBUS, HandleException);
    
    //程序通过端口发送消息失败导致的程序中止信号
    signal(SIGPIPE, HandleException);
}

- (void)regist {
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
    [[self class] RegisterSignalHandler];
}

- (void)unRegist {
    NSSetUncaughtExceptionHandler(NULL);
}

- (NSString *)attachmentForException:(NSException *)exception {
    NSLog(@"%@",exception);
    NSLog(@"%@",[NSThread callStackSymbols]);
    return nil;
}

- (void)toggleProxyMabeCashMethod {
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    
    /// NSMutableArray
    Class clsM = NSClassFromString(@"__NSArrayM");
    InstanceMethodExchangeImplementations(clsM, @selector(insertObject:atIndex:), @selector(zh_insertObject:atIndex:));
    InstanceMethodExchangeImplementations(clsM, @selector(setObject:atIndexedSubscript:), @selector(zh_setObject:atIndexedSubscript:));
    InstanceMethodExchangeImplementations(clsM, @selector(objectAtIndexedSubscript:), @selector(zh_objectAtIndexedSubscript:));
    InstanceMethodExchangeImplementations(clsM, @selector(removeObjectAtIndex:), @selector(zh_removeObjectAtIndex:));
    InstanceMethodExchangeImplementations(clsM, @selector(objectAtIndex:), @selector(zh_objectAtIndex:));
    
    /// NSArray
    Class clsI = NSClassFromString(@"__NSArrayI");
    InstanceMethodExchangeImplementations(clsI, @selector(objectAtIndexedSubscript:), @selector(zh_objectAtIndexedSubscript:));
    InstanceMethodExchangeImplementations(clsI, @selector(objectAtIndex:), @selector(zh_objectAtIndex:));
    InstanceMethodExchangeImplementations([NSArray class], @selector(objectsAtIndexes:), @selector(zh_objectsAtIndexes:));
    
    /// NSMutableDictionary
    Class mDicCls = NSClassFromString(@"__NSDictionaryM");
    InstanceMethodExchangeImplementations(mDicCls, @selector(setObject:forKey:), @selector(zh_setObject:forKey:));
    InstanceMethodExchangeImplementations(mDicCls, @selector(setObject:forKeyedSubscript:), @selector(zh_setObject:forKeyedSubscript:));
    InstanceMethodExchangeImplementations(mDicCls, @selector(objectForKeyedSubscript:), @selector(zh_objectForKeyedSubscript:));
    InstanceMethodExchangeImplementations(mDicCls, @selector(removeObjectForKey:), @selector(zh_removeObjectForKey:));
    
    /// NSDictionary
    ClassMethodExchangeImplementations([NSDictionary class], @selector(dictionaryWithObjects:forKeys:count:), @selector(zh_dictionaryWithObjects:forKeys:count:));
    
    /// NSObject
    InstanceMethodExchangeImplementations([NSObject class], @selector(methodSignatureForSelector:), @selector(zh_methodSignatureForSelector:));
    InstanceMethodExchangeImplementations([NSObject class], @selector(forwardInvocation:), @selector(zh_forwardInvocation:));
    ClassMethodExchangeImplementations([NSObject class], @selector(methodSignatureForSelector:), @selector(zh_methodSignatureForSelector:));
    ClassMethodExchangeImplementations([NSObject class], @selector(forwardInvocation:), @selector(zh_forwardInvocation:));
    
    InstanceMethodExchangeImplementations([NSObject class], @selector(setValue:forKey:), @selector(zh_setValue:forKey:));
    InstanceMethodExchangeImplementations([NSObject class], @selector(setValue:forKeyPath:), @selector(zh_setValue:forKeyPath:));
    InstanceMethodExchangeImplementations([NSObject class], @selector(setValue:forUndefinedKey:), @selector(zh_setValue:forUndefinedKey:));
    
#pragma clang diagnostic pop
}

- (void)setEnableAvoidCrash:(BOOL)enableAvoidCrash {
    
    if (self.isEnableAvoidCrash == enableAvoidCrash) { return; }
    
    objc_setAssociatedObject(self, kEnableAvoidCrash, @(enableAvoidCrash), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self toggleProxyMabeCashMethod];
}

- (BOOL)isEnableAvoidCrash {
    return [objc_getAssociatedObject(self, kEnableAvoidCrash) boolValue];
}

@end

void InstanceMethodExchangeImplementations(Class cls,SEL sel1,SEL sel2) {
    Method mth1 = class_getInstanceMethod(cls, sel1);
    Method mth2 = class_getInstanceMethod(cls, sel2);
    method_exchangeImplementations(mth1, mth2);
}

void ClassMethodExchangeImplementations(Class cls,SEL sel1,SEL sel2) {
    Method mth1 = class_getClassMethod(cls, sel1);
    Method mth2 = class_getClassMethod(cls, sel2);
    method_exchangeImplementations(mth1, mth2);
}
