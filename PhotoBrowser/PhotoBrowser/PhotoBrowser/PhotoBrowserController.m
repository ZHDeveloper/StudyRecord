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
#import "UIView+PhotoBrowser.h"
#import <objc/runtime.h>

@interface PhotoBrowserController () <UIScrollViewDelegate,UIGestureRecognizerDelegate> {
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
    // 拖拽手势：移动图片
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:panGesture];
    
    // 单击手势：dismiss
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAction)];
    tapGesture.delegate = self;
    [self.view addGestureRecognizer:tapGesture];
    
    // 双击手势：放大图片
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapAction:)];
    doubleTapGesture.delegate= self;
    doubleTapGesture.numberOfTapsRequired = 2;
    [tapGesture requireGestureRecognizerToFail:doubleTapGesture];
    [self.view addGestureRecognizer:doubleTapGesture];
    
    // 长按分享图片
    UILongPressGestureRecognizer *pressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction)];
    pressGesture.delegate = self;
    [self.view addGestureRecognizer:pressGesture];
}

- (void)longPressAction {
    
    PhotoBrowserCell *tile = self.visualCell;
    if (!tile.imageView.image) {
        return;
    }
    UIActivityViewController *activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:@[tile.imageView.image] applicationActivities:nil];
    if ([activityViewController respondsToSelector:@selector(popoverPresentationController)]) {
        activityViewController.popoverPresentationController.sourceView = self.view;
    }
    
    [self presentViewController:activityViewController animated:YES completion:nil];
}

- (void)doubleTapAction:(UITapGestureRecognizer *)g {

    PhotoBrowserCell *cell = self.visualCell;
    if (cell) {
        if (cell.zoomScale > 1) {
            [cell setZoomScale:1 animated:YES];
        }else{
            CGPoint touchPoint = [g locationInView:cell.imageView];
            CGFloat newZoomScale = cell.maximumZoomScale;
            CGFloat xsize = self.view.width / newZoomScale;
            CGFloat ysize = self.view.height / newZoomScale;
            [cell zoomToRect:CGRectMake(touchPoint.x - xsize/2, touchPoint.y - ysize/2, xsize, ysize) animated:YES];
        }
    }
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

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
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
