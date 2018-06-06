//
//  main.m
//  __attribute__
//
//  Created by ZhiHua Shen on 2018/6/6.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

__attribute__((constructor)) void beforeMain() {
    NSLog(@"before main.");
}

__attribute__((destructor)) void afterMain() {
    NSLog(@"after main.");
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
//        return 0;
    }
}
