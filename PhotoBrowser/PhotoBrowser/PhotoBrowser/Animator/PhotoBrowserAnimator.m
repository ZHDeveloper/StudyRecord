//
//  PhotoBrowserAnimator.m
//  PhotoBrowser
//
//  Created by ZhiHua Shen on 2018/5/7.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "PhotoBrowserAnimator.h"
#import "UIView+PhotoBrowser.h"
#import "PhotoBrowserController.h"
#import "PhotoBrowserCell.h"
#import "PhotoBrowserItem.h"

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
    return 0.3;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    self.isPresenting ? [self presentAnimateTransition:transitionContext] : [self dismissAnimateTransition:transitionContext];
}

- (void)presentAnimateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *containerView = [transitionContext containerView];
    
    PhotoBrowserController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *toView = toVC.view;
    
    toView.frame = [transitionContext finalFrameForViewController:toVC];
    [toView layoutIfNeeded];
    
    // 将展现的控制器视图添加到容器视图
    [containerView addSubview:toView];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    UIView *fromImageView = self.presentItem.thumbView;
    
    if (fromImageView) {
        
        UIImage *image = self.presentItem.thumbImage;
        // 设置背景高斯模糊图片
        toVC.bgImage = image;
        
        // 复制转场的ImageView
        UIImageView *dummyView = [[UIImageView alloc] initWithImage: image];
        
        [toView addSubview:dummyView];

        // 坐标系转换
        dummyView.frame = [fromImageView.superview convertRect:fromImageView.frame toView:containerView];
        
        toView.alpha = 0;
        toVC.visualCell.imageView.hidden = YES;
        
        [UIView animateWithDuration:duration animations:^{
            dummyView.frame = [self presentRectWithImageView:dummyView];
            toView.alpha = 1;
        } completion:^(BOOL finished) {
            toVC.visualCell.imageView.hidden = NO;
            [dummyView removeFromSuperview];
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
    }
    else {
        
        toView.alpha = 0.0;
        [toView.layer setValue:@(0.95) forKey:@"transform.scale"];

        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut animations:^{
            toView.alpha = 1;
            [toView.layer setValue:@(1) forKey:@"transform.scale"];
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
        
    }
    
}

- (void)dismissAnimateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *containerView = [transitionContext containerView];
    
    PhotoBrowserController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];

    NSTimeInterval duration = [self transitionDuration:transitionContext];

    PhotoBrowserItem *item = fromVC.photoItems[fromVC.currentIndex];

    if (item.thumbView) {
        
        // 获取需要动画的ImageView，并添加容器视图
        UIImageView *fromImageView = fromVC.visualCell.imageView;
        
        // 坐标系转换
        fromImageView.frame = [fromImageView.superview convertRect:fromImageView.frame toView:containerView];
        
        // 添加的容器视图
        [containerView addSubview:fromImageView];
        
        // 计算目标偏移Rect
        CGRect toRect = [item.thumbView.superview convertRect:item.thumbView.frame toView:containerView];
        
        [UIView animateWithDuration:duration animations:^{
            
            fromView.alpha = 0;
            fromImageView.frame = toRect;
            
        } completion:^(BOOL finished) {
            [fromImageView removeFromSuperview];
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
        
    }
    else {
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut animations:^{
            fromView.alpha = 0.0;
            [fromView.layer setValue:@(0.95) forKey:@"transform.scale"];
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];

    }
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
