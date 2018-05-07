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
void *const kNaviBar = "kNaviBar";

#define NaviBarColor kColorHex(0xF8F8F8)
#define LineLayerColor kColorHex(0xD9D9D9)
#define kColorHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface UIScrollView ()

@property (nonatomic,strong,readonly) UIImageView *imageView;

@end

@implementation UIScrollView (HeaderScaleView)

- (void)layoutScaleViews {
    
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y;
    
    self.scaleBar.frame = CGRectMake(x, y, CGRectGetWidth(self.bounds), self.scaleImageHeight);
    self.contentInset = UIEdgeInsetsMake(self.scaleImageHeight, 0, 0, 0);
    
    self.scrollIndicatorInsets = self.contentInset;
    
    self.imageView.frame = self.scaleBar.bounds;
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    //添加观察者,确保只添加一次
    if (objc_getAssociatedObject(self, _cmd)) { return; }
    objc_setAssociatedObject(self, _cmd, @"LaunchOnce", OBJC_ASSOCIATION_RETAIN);
    
    [self addObserver:self forKeyPath:@"contentOffset" options:(NSKeyValueObservingOptionNew) context:nil];
    
    [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];

    //添加子控件
    [self.scaleBar addSubview:self.imageView];
    [self.superview insertSubview:self.scaleBar aboveSubview:self];

    [self parentViewController].automaticallyAdjustsScrollViewInsets = NO;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if (self.scaleImageHeight == 0) { return; }

    CGFloat distance = self.contentOffset.y + self.contentInset.top;
    
    //向下拉
    if (distance < 0) {
        self.scaleBar.zh_y = 0;
        self.scaleBar.zh_height = self.scaleImageHeight - distance;
        // 下面改过它的alpha覆盖设置
        self.imageView.alpha = 1;
    }
    else {
        self.scaleBar.zh_height = self.scaleImageHeight;
        
        // 最多向上滚动的距离
        CGFloat min = self.scaleImageHeight - 64;
        self.scaleBar.zh_y = -MIN(distance, min);
        
        CGFloat progress = 1 - distance / min;
        
        self.imageView.alpha = progress;
    }
    
    self.scaleBar.zh_width = CGRectGetWidth(self.bounds);
    self.imageView.zh_height = self.scaleBar.zh_height;
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"contentOffset"];
}

- (UINavigationBar *)scaleBar {
    UINavigationBar *headerView = objc_getAssociatedObject(self, kNaviBar);
    
    if (!headerView) {
        headerView = [[UINavigationBar alloc] init];
        objc_setAssociatedObject(self, kNaviBar, headerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        return headerView;
    }
    
    return headerView;
}

- (UIImageView *)imageView {

    UIImageView *imageView = objc_getAssociatedObject(self, kImageView);

    if (!imageView) {
        imageView = [[UIImageView alloc] init];
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
    
    [self layoutScaleViews];
}

- (void)setScaleImageHeight:(CGFloat)scaleImageHeight {
    objc_setAssociatedObject(self, kScaleImageHeight, @(scaleImageHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self layoutScaleViews];
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
