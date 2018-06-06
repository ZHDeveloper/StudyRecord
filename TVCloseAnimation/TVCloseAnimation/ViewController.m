//
//  ViewController.m
//  TVCloseAnimation
//
//  Created by ZhiHua Shen on 2018/5/26.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "ViewController.h"
#import "TVCloseView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    TVCloseView *view = [[TVCloseView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:view];
    
    [view startAnimation];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

@end
