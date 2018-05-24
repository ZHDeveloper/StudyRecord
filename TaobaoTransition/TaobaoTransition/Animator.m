//
//  Animator.m
//  TaobaoTransition
//
//  Created by ZhiHua Shen on 2018/5/24.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "Animator.h"

@interface Animator() {
    BOOL isDismiss;
}

@property (nonatomic,strong) UIView *maskView;

@end

@implementation Animator

- (instancetype)init {
    if ([super init]) {
        self.maskView = [[UIView alloc] init];
        self.maskView.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self->isDismiss = NO;
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self->isDismiss = YES;
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.4;
}

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    self->isDismiss ? [self dismissedAnimateTransition:transitionContext] : [self presentedAnimateTransition:transitionContext];
}

- (void)presentedAnimateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    if (!fromView) {
        fromView = fromVC.view;
    }
    
    [containerView addSubview:self.maskView];
    [containerView addSubview:toView];
    
    self.maskView.frame = containerView.bounds;
    
    CGFloat height = CGRectGetHeight(containerView.bounds);
    CGFloat width = CGRectGetWidth(containerView.bounds);
    
    toView.frame = CGRectMake(0, height*0.4, width, height*0.6);
    [toView layoutIfNeeded];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    // fromView动画
    fromView.layer.zPosition = -200;
    
    [UIView animateWithDuration:duration * 0.5 animations:^{
        
        fromView.layer.transform = [self middleTransform];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:duration * 0.5 animations:^{
            
            fromView.layer.transform = [self finalTransform];
            
        }];
        
    }];
    
    // toView动画
    toView.transform = CGAffineTransformMakeTranslation(0, height*0.6);
    self.maskView.alpha = 0;
    [UIView animateWithDuration:duration animations:^{
        toView.transform = CGAffineTransformIdentity;
        self.maskView.alpha = 0.4;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:finished];
    }];
    
}

- (void)dismissedAnimateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];

    if (!toView) {
        toView = toVC.view;
    }
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration * 0.5 animations:^{
        
        toView.layer.transform = [self middleTransform];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:duration * 0.5 animations:^{
            toView.layer.transform = CATransform3DIdentity;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:finished];
        }];
        
    }];
    
    [UIView animateWithDuration:duration animations:^{
        CGFloat height = CGRectGetHeight(fromView.bounds);
        fromView.transform = CGAffineTransformMakeTranslation(0, height);
        self.maskView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];
    }];
}

- (CATransform3D)middleTransform {
    CATransform3D t1 = CATransform3DIdentity;
    t1.m34 = -1.0/800;
    t1 = CATransform3DScale(t1, 0.95, 0.95, 1);
    t1 = CATransform3DRotate(t1, 15.0 * M_PI/180.0, 1, 0, 0);
    return t1;
}

- (CATransform3D)finalTransform {
    CATransform3D t2 = CATransform3DIdentity;
    t2.m34 = -1.0/800;
    t2 = CATransform3DTranslate(t2, 0, -20, 0);
    t2 = CATransform3DScale(t2, 0.85, 0.85, 1);
    return t2;
}


@end
