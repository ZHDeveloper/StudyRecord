//
//  ViewController.m
//  XCConfig
//
//  Created by ZhiHua Shen on 2018/6/25.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) void(^block)(void);

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    NSLog(@"%@",BaseUrl);
    
#ifdef DEBUG
    NSLog(@"DEBUG");
#else
    NSLog(@"RELEASE");
#endif
    
    // 测试在debug,模式下导入MLeaksFinder
    self.block = ^(void) {
        NSLog(@"%@--%@",self);
    };


}

- (void)dealloc
{
    NSLog(@"---");
}


@end
