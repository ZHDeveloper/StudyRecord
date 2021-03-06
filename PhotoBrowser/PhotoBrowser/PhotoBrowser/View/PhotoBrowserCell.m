//
//  PhotoBrowserCell.m
//  PhotoBrowser
//
//  Created by ZhiHua Shen on 2018/5/9.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "PhotoBrowserCell.h"
#import "YYWebImage.h"
#import "UIView+PhotoBrowser.h"

#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

@implementation PhotoBrowserCell

- (instancetype)init{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    if (@available(iOS 11.0,*)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    self.delegate = self;
    self.bouncesZoom = YES;
    self.maximumZoomScale = 3;
    self.multipleTouchEnabled = YES;
    self.alwaysBounceVertical = NO;
    self.showsVerticalScrollIndicator = YES;
    self.showsHorizontalScrollIndicator = NO;
    self.frame = [UIScreen mainScreen].bounds;
    
    _imageContainerView = [UIView new];
    _imageContainerView.clipsToBounds = YES;
    [self addSubview:_imageContainerView];
    
    _imageView = [YYAnimatedImageView new];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    _imageView.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.500];
    [_imageContainerView addSubview:_imageView];
    
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.frame = CGRectMake(0, 0, 40, 40);
    _progressLayer.cornerRadius = 20;
    _progressLayer.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5].CGColor;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(_progressLayer.bounds, 7, 7) cornerRadius:40 / 2 - 7];
    _progressLayer.path = path.CGPath;
    _progressLayer.fillColor = [UIColor clearColor].CGColor;
    _progressLayer.strokeColor = [UIColor whiteColor].CGColor;
    _progressLayer.lineWidth = 4;
    _progressLayer.lineCap = kCALineCapRound;
    _progressLayer.strokeStart = 0;
    _progressLayer.strokeEnd = 0;
    _progressLayer.hidden = YES;
    [self.layer addSublayer:_progressLayer];
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //把_progressLayer移动到视图的中间
    _progressLayer.frame = CGRectMake(CGRectGetWidth(self.bounds)/2 - _progressLayer.frame.size.width /2, CGRectGetHeight(self.bounds)/2 - _progressLayer.frame.size.height/2, _progressLayer.frame.size.width, _progressLayer.frame.size.height);
}

- (void)setItem:(PhotoBrowserItem *)item{
    if (_item == item) {
        return;
    }

    _item =item;
    _itemDidLoad = NO;

    [self setZoomScale:1.0 animated:YES];
    self.maximumZoomScale = 1;

    [_imageView yy_cancelCurrentImageRequest];
    [_imageView.layer removeAnimationForKey:@"yykit.fade"];

    _progressLayer.hidden = NO;
    [CATransaction  begin];
    [CATransaction  setDisableActions:YES];
    _progressLayer.strokeEnd = 0;
    _progressLayer.hidden = YES;
    [CATransaction  commit];

    if (!_item) {
        _imageView.image = nil;
        return;
    }

    @weakify(self)
    [_imageView yy_setImageWithURL:item.largeImageURL placeholder:item.thumbImage options:kNilOptions progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        @strongify(self)
        CGFloat progress = receivedSize / (float)expectedSize;
        progress = progress < 0.01 ? 0.01 : progress > 1 ? 1 : progress;
        if (isnan(progress)) progress = 0;
        self.progressLayer.hidden = NO;
        self.progressLayer.strokeEnd = progress;
    } transform:nil completion:^(UIImage *image, NSURL *url, YYWebImageFromType from, YYWebImageStage stage, NSError *error) {
        @strongify(self)
        self.progressLayer.hidden = YES;
        if (stage == YYWebImageStageFinished) {
            self.maximumZoomScale = 3;
            if (image) {
                self->_itemDidLoad = YES;

                [self resizeSubviewSize];
                CATransition * transition = [CATransition animation];
                transition.duration = 0.1;
                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
                [self.layer addAnimation:transition forKey:@"yykit.fade"];
            }
        }

    }];

    [self resizeSubviewSize];
}

- (void)resizeSubviewSize{
    _imageContainerView.origin = CGPointZero;
    _imageContainerView.width = self.width;
    
    UIImage * image = _imageView.image;
    if (image.size.height / image.size.width > self.height / self.width) {
        _imageContainerView.height = floor(image.size.height / (image.size.width / self.width));
    }else{
        CGFloat height = image.size.height / image.size.width * self.width;
        if (height < 1 || isnan(height)) {
            height = self.height;
        }
        height = floor(height);
        _imageContainerView.height = height;
        _imageContainerView.centerY = self.height/2;
    }
    
    if (_imageContainerView.height > self.height && _imageContainerView.height - self.height < 1) {
        _imageContainerView.height = self.height;
    }
    self.contentSize = CGSizeMake(self.width , MAX(_imageContainerView.height, self.height));
    [self scrollRectToVisible:self.bounds animated:NO];
    if (_imageContainerView.height <= self.height) {
        self.alwaysBounceVertical = NO;
    }else {
        self.alwaysBounceVertical = YES;
    }
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    _imageView.frame = _imageContainerView.bounds;
    [CATransaction commit];
    
}

#pragma mark -- UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imageContainerView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    UIView * subView = _imageContainerView;
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width) ? (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height) ?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    
    subView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, scrollView.contentSize.height * 0.5 + offsetY);
}

@end
