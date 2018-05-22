//
//  ViewController.m
//  横屏测试
//
//  Created by ZhiHua Shen on 2018/5/22.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonConstH;

@property (nonatomic,assign,getter=isFullScreen) BOOL fullscreen;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (IBAction)buttonAction:(UIButton *)sender {
    
    if (self.isFullScreen) {
        
        [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
        
        [UIView animateWithDuration:0.25 animations:^{
            self.buttonConstH.constant = 250;
            [self.view layoutIfNeeded];
        }];
        
        self.fullscreen = NO;
    }
    else {

        [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeRight) forKey:@"orientation"];
        
        [UIView animateWithDuration:0.25 animations:^{
            self.buttonConstH.constant = CGRectGetHeight([UIScreen mainScreen].bounds);
            [self.view layoutIfNeeded];
        }];
        
        self.fullscreen = YES;
    }
    
}

@end
