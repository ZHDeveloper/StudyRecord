//
//  ViewController.m
//  OCAvoidCrashKitDemo
//
//  Created by ZhiHua Shen on 2018/6/5.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "ViewController.h"
#import "CrashProxy.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [CrashProxy sharedCrashProxy].enableAvoidCrash = YES;

//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    free((__bridge void *)(dict));
//    dict[@"aa"];
    
    NSMutableArray *array = [NSMutableArray array];
    array[10];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    abort();
}

@end

@implementation Person

- (void)test {
    
}

@end
