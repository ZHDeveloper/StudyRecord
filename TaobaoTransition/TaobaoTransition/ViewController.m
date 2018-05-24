//
//  ViewController.m
//  TaobaoTransition
//
//  Created by ZhiHua Shen on 2018/5/24.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "Animator.h"

@interface ViewController () {
    Animator *animator;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    Animator *animator = [[Animator alloc] init];
    self->animator = animator;
    
    SecondViewController *vc = [[SecondViewController alloc] init];
    
    vc.transitioningDelegate = animator;
    vc.modalPresentationStyle = UIModalPresentationCustom;
    
    [self presentViewController:vc animated:YES completion:nil];
}


@end
