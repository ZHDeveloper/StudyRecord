//
//  PhotoBrowserController.m
//  PhotoBrowser
//
//  Created by ZhiHua Shen on 2018/5/7.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "PhotoBrowserController.h"
#import "PhotoBrowserAnimator.h"
#import "PhotoBrowserCell.h"
#import "PhotoBrowserItem.h"
#import "UIView+YYAdd.h"
#import <objc/runtime.h>

@interface PhotoBrowserController () <UIScrollViewDelegate> {
    PhotoBrowserAnimator *_animator;
}

@property (nonatomic,strong) PhotoBrowserAnimator *animator;

@property (nonatomic, strong) NSMutableArray <PhotoBrowserCell *>*cells;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, assign) CGPoint panGestureBeginPoint;

@end

@implementation PhotoBrowserController

+ (instancetype)browserWithSelectedIndex:(NSInteger)index phothItems:(NSArray<PhotoBrowserItem *> *)photoItems {

    PhotoBrowserController *browserVC = [[UIStoryboard storyboardWithName:@"PhotoBrowser" bundle:nil] instantiateInitialViewController];
    
    browserVC.currentIndex = index;
    browserVC.photoItems = photoItems;
    
    browserVC.modalPresentationStyle = UIModalPresentationCustom;
    PhotoBrowserAnimator *animator = [[PhotoBrowserAnimator alloc] initWith:photoItems[index]];
    browserVC.animator = animator;
    
    browserVC.transitioningDelegate = animator;

    return browserVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 11.0,*)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    [self initialGesutres];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (objc_getAssociatedObject(self, _cmd)) { return; }
    objc_setAssociatedObject(self, _cmd, @"LaunchOnce", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    //添加子空间
    [self initialCells];
}

- (void)initialCells {
    
    CGSize sSize = [UIScreen mainScreen].bounds.size;
    
    self.scrollView.contentSize = CGSizeMake(sSize.width*self.photoItems.count, sSize.height);
    
    self.scrollView.contentOffset = CGPointMake(sSize.width*self.currentIndex, 0);
    
    for (int i = 0; i<self.photoItems.count; i++) {
        
        PhotoBrowserCell *cell = [[PhotoBrowserCell alloc] init];
        
        cell.frame = CGRectMake(i*sSize.width, 0, sSize.width, sSize.height);
        
        cell.item = self.photoItems[i];
        cell.tag = 1000+i;
        
        [self.scrollView addSubview:cell];
    }
}

#pragma mark = Gestures
- (void)initialGesutres {
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:panGesture];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAction)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)dismissAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)panAction:(UIPanGestureRecognizer *)gesture {
    
    CGPoint translation = [gesture translationInView:self.view];
    CGFloat percentage = fabs(translation.y) / CGRectGetHeight([UIScreen mainScreen].bounds) / 1.5;
    
    CGPoint velocity = [gesture velocityInView:self.view];
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            break;
        case UIGestureRecognizerStateChanged:
            self.scrollView.top = translation.y;
            break;
        case UIGestureRecognizerStateEnded:
            
            if (percentage > 0.1) {
                CGFloat top = (velocity.y<0) ? -CGRectGetHeight([UIScreen mainScreen].bounds) : CGRectGetHeight([UIScreen mainScreen].bounds);
                [UIView animateWithDuration:0.25 animations:^{
                    self.view.alpha = 0;
                    self.scrollView.top = top;
                } completion:^(BOOL finished) {
                    [self dismissViewControllerAnimated:NO completion:nil];
                }];
            }
            else {
                [UIView animateWithDuration:0.25 animations:^{
                    self.scrollView.top = 0;
                }];
            }
            
            break;
        case UIGestureRecognizerStateCancelled:
            self.scrollView.top = 0;
            break;
        default:
            break;
    }
    

}


#pragma mark - UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSInteger page = _scrollView.contentOffset.x / _scrollView.width + 0.5;
    
    self.bgImage = self.photoItems[page].thumbImage;
    
    self.currentIndex = page;
}

- (PhotoBrowserCell *)visualCell {
    
    NSInteger page = _scrollView.contentOffset.x / _scrollView.width + 0.5;
    
    return (PhotoBrowserCell *)[_scrollView viewWithTag:(1000+page)];
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
