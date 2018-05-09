//
//  PhotoBrowserController.m
//  PhotoBrowser
//
//  Created by ZhiHua Shen on 2018/5/7.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "PhotoBrowserController.h"
#import "PhotoBrowserAnimator.h"

@interface PhotoBrowserController () {
    PhotoBrowserAnimator *_animator;
}

@end

@implementation PhotoBrowserController

- (instancetype)initWithItems:(NSArray *)photoItems fromView:(UIView *)fromView {
    
    if ([super init]) {
        
        self.view.backgroundColor = [UIColor whiteColor];
        
        _animator = [[PhotoBrowserAnimator alloc] initWith:fromView];
        
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = _animator;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
