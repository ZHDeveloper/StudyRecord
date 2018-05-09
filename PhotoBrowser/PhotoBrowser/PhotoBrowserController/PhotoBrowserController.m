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
    
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    
    blurView.frame = self.view.bounds;
    
    [self.view addSubview:blurView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setBgImage:(UIImage *)bgImage {
    self.view.layer.contents = (__bridge id _Nullable)(bgImage.CGImage);
    self.view.layer.contentsGravity = kCAGravityResizeAspectFill;
}

- (UIImage *)bgImage {
    CGImageRef cgImage = (__bridge CGImageRef)(self.view.layer.contents);
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    return image;
}

@end
