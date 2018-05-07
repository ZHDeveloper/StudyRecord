//
//  UIScrollView+HeaderView.m
//  HeaderView
//
//  Created by ZhiHua Shen on 2018/5/7.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "UIScrollView+HeaderView.h"
#import <objc/runtime.h>

void *const kScaleImage = "kScaleImage";
void *const kScaleImageHeight = "kScaleImageHeight";
void *const kImageView = "kImageView";

@interface UIScrollView ()

@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation UIScrollView (HeaderScaleView)

- (void)layoutImageView {
    
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y;
    
    self.imageView.frame = CGRectMake(x, y, CGRectGetWidth(self.bounds), self.scaleImageHeight);
    self.contentInset = UIEdgeInsetsMake(self.scaleImageHeight, 0, 0, 0);
    
    self.scrollIndicatorInsets = self.contentInset;
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    if (!self.imageView.superview) {
        [self.superview insertSubview:self.imageView aboveSubview:self];
    }
    
    [self parentViewController].automaticallyAdjustsScrollViewInsets = NO;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutImageView];
}

- (void)dealloc {

    

}

- (UIImageView *)imageView {
    
    UIImageView *imageView = objc_getAssociatedObject(self, kImageView);
    
    if (!imageView) {
        imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor redColor];
        
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;

        objc_setAssociatedObject(self, kImageView, imageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        return imageView;
    }
    
    return imageView;
}

- (nullable UIImage *)scaleImage {
    return objc_getAssociatedObject(self, kScaleImage);
}

- (void)setScaleImage:(UIImage *)scaleImage {
    
    objc_setAssociatedObject(self, kScaleImage, scaleImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.imageView.image = scaleImage;
    
    [self layoutImageView];
}

- (void)setScaleImageHeight:(CGFloat)scaleImageHeight {
    objc_setAssociatedObject(self, kScaleImageHeight, @(scaleImageHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self layoutImageView];
}

- (CGFloat)scaleImageHeight {
    NSNumber *height = objc_getAssociatedObject(self, kScaleImageHeight);
    if (!height) {
        return 0; //0；
    }
    return height.floatValue;
}

@end


@implementation UIResponder (Ext)

- (UIViewController *)parentViewController {

    UIResponder *parentResponder = self;
    
    while (parentResponder) {
        parentResponder = parentResponder.nextResponder;
        if ([parentResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)parentResponder;
        }
    }
    return nil;
}

@end


@implementation UIView (CS_Frame)

- (CGPoint)zh_viewOrigin {
    return self.frame.origin;
}

- (void)setZh_viewOrigin:(CGPoint)zh_viewOrigin {
    CGRect newFrame = self.frame;
    newFrame.origin = zh_viewOrigin;
    self.frame = newFrame;
}

- (CGSize)zh_viewSize {
    return self.frame.size;
}

- (void)setZh_viewSize:(CGSize)zh_viewSize {
    CGRect newFrame = self.frame;
    newFrame.size = zh_viewSize;
    self.frame = newFrame;
}

#pragma mark - Frame Origin
- (CGFloat)zh_x {
    return self.frame.origin.x;
}

- (void)setZh_x:(CGFloat)zh_x {
    CGRect newFrame = self.frame;
    newFrame.origin.x = zh_x;
    self.frame = newFrame;
}

- (CGFloat)zh_y {
    return self.frame.origin.y;
}

- (void)setZh_y:(CGFloat)zh_y {
    CGRect newFrame = self.frame;
    newFrame.origin.y = zh_y;
    self.frame = newFrame;
}

#pragma mark - Frame Size
- (CGFloat)zh_width {
    return self.frame.size.width;
}

- (void)setZh_width:(CGFloat)zh_width {
    CGRect newFrame = self.frame;
    newFrame.size.width = zh_width;
    self.frame = newFrame;
}

- (CGFloat)zh_height {
    return self.frame.size.height;
}

- (void)setZh_height:(CGFloat)zh_height {
    CGRect newFrame = self.frame;
    newFrame.size.height = zh_height;
    self.frame = newFrame;
}

@end
