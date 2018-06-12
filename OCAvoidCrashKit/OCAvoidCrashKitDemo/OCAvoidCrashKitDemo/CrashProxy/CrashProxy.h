//
//  CrashProxy.h
//  CrashProxyDemo
//
//  Created by ZhiHua Shen on 2018/6/5.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#ifdef DEBUG
#define ZHLog(...) NSLog(@"\n\n😂😂😂😂:%s\nLogInfo:%@\n\n", __func__, [NSString stringWithFormat:__VA_ARGS__])
#else
#define ZHLog(...)
#endif

// .h
#define singleton_interface(class) + (instancetype)shared ## class;
// .m
#define singleton_implementation(class) \
static class *_instance; \
\
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [super allocWithZone:zone]; \
    }); \
    \
    return _instance; \
} \
\
+ (instancetype)shared ## class \
{ \
    if (_instance == nil) { \
        _instance = [[class alloc] init]; \
    } \
    \
    return _instance; \
}

@interface CrashProxy : NSObject

singleton_interface(CrashProxy)

@property (nonatomic,assign,getter = isEnableAvoidCrash) BOOL enableAvoidCrash;

- (void)regist;
- (void)unRegist;

- (NSString *)attachmentForException:(NSException *)exception;

@end

void InstanceMethodExchangeImplementations(Class cls,SEL sel1,SEL sel2);
void ClassMethodExchangeImplementations(Class cls,SEL sel1,SEL sel2);
