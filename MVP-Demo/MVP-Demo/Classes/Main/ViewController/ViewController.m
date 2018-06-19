//
//  ViewController.m
//  MVP-Demo
//
//  Created by ZhiHua Shen on 2018/6/19.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "ViewController.h"
#import "HomePresenter.h"

@interface ViewController () <HomeProtocol>

@property (nonatomic, strong) HomePresenter *presenter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 初始化并绑定视图
    self.presenter = [[HomePresenter alloc] initWithView:self];
    
    // 通过block
    [self.presenter getHomeDataWithSuccess:^(NSArray *data) {
        
        NSLog(@"%@",data);
        
    } withFailuer:nil];
}

- (void)onLoadHomeData:(NSArray<HomeModel *> *)list {
    
    NSLog(@"%@",list);
    
}

- (void)dealloc {
    NSLog(@"ViewController dealloc");
}

@end
