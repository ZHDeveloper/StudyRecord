//
//  ViewController.m
//  TwitterLaunchAnimation
//
//  Created by ZhiHua Shen on 2018/5/24.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "ViewController.h"
#import "LaunchViewController.h"
#import <objc/runtime.h>
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //确保执行一次
    if (objc_getAssociatedObject(self, _cmd)) { return; }
    objc_setAssociatedObject(self, _cmd, @"launch", OBJC_ASSOCIATION_RETAIN);
    
    UIImage *iamge = [self snapshotImage];
    
    LaunchViewController *launchVC = [[LaunchViewController alloc] initWithDummyImage:iamge];
    launchVC.view.frame = self.view.bounds;
    
    [self.view addSubview:launchVC.view];
    [self addChildViewController:launchVC];
    [launchVC didMoveToParentViewController:self];
}

- (UIImage *)snapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    SecondViewController *vc = [[SecondViewController alloc] init];
    
    [self presentViewController:vc animated:YES completion:nil];
}

@end
