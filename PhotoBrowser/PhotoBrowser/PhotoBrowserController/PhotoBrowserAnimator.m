//
//  PhotoBrowserAnimator.m
//  PhotoBrowser
//
//  Created by ZhiHua Shen on 2018/5/7.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "PhotoBrowserAnimator.h"
#import "UIView+YYAdd.h"
#import "PhotoBrowserController.h"

@interface PhotoBrowserAnimator ()

@property (nonatomic,assign) BOOL isPresenting;

@end

@implementation PhotoBrowserAnimator 

- (instancetype)initWith:(PhotoBrowserItem *)presentItem {
    if ([super init]) {
        self.presentItem = presentItem;
    }
    return self;
}

#pragma mark - UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.isPresenting = YES;
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.isPresenting = NO;
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    self.isPresenting ? [self presentAnimateTransition:transitionContext] : [self dismissAnimateTransition:transitionContext];
}

- (void)presentAnimateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {

    PhotoBrowserController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    UIImage *image = self.presentItem.thumbImage;
    UIImageView *dummyView = [[UIImageView alloc] initWithImage: image];
    
    toVC.bgImage = image;
    
    UIView *fromView = self.presentItem.thumbView;
    
    dummyView.frame = [fromView.superview convertRect:fromView.frame toView:containerView];
    
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [containerView addSubview:toView];
    
    toView.alpha = 0;
    
    [toView addSubview:dummyView];
    
    [UIView animateWithDuration:0.25 animations:^{
        dummyView.frame = [self presentRectWithImageView:dummyView];
        toView.alpha = 1;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        [dummyView removeFromSuperview];
    }];
}

- (void)dismissAnimateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {

    PhotoBrowserController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    UIView *containerView = [transitionContext containerView];

    UIImageView *fromImageView = fromVC.visualCell.imageView;
    
    fromImageView.frame = [fromImageView.superview convertRect:fromImageView.frame toView:containerView];
    
    [containerView addSubview:fromImageView];
    
    PhotoBrowserItem *item = fromVC.photoItems[fromVC.currentIndex];
    
    CGRect toRect = [item.thumbView.superview convertRect:item.thumbView.frame toView:containerView];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        fromView.alpha = 0;
        fromImageView.frame = toRect;
        
    } completion:^(BOOL finished) {
        [fromImageView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
    
}

/// 根据图像计算展现目标尺寸
- (CGRect)presentRectWithImageView:(UIImageView *)imageView {
    UIImage *image = imageView.image;
    
    if (image == nil) {
        return imageView.frame;
    }
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGSize imageSize = screenSize;
    
    imageSize.height = image.size.height * imageSize.width / image.size.width;
    
    CGRect rect = CGRectMake(0, 0, imageSize.width, imageSize.height);
    
    if (imageSize.height < screenSize.height) {
        rect.origin.y = (screenSize.height - imageSize.height) * 0.5;
    }
    
    return rect;
}

@end
