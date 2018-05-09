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
#import "UIView+YYAdd.h"

@interface PhotoBrowserController () {
    PhotoBrowserAnimator *_animator;
}

@property (nonatomic,strong) PhotoBrowserAnimator *animator;

@property (nonatomic, strong) NSMutableArray <PhotoBrowserCell *>*cells;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIStackView *stackView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stackConstraintW;

@end

@implementation PhotoBrowserController

+ (instancetype)browserWith:(NSArray<PhotoBrowserItem *> *)photoItems fromView:(UIView *)fromView {
    
    PhotoBrowserController *browserVC = [[UIStoryboard storyboardWithName:@"PhotoBrowser" bundle:nil] instantiateInitialViewController];
    
    browserVC.photoItems = photoItems;
    browserVC.animator = [[PhotoBrowserAnimator alloc] initWith:fromView];

    return browserVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bgImage = [UIImage imageNamed:@"72635b6agw1eyqehvujq1j218g0p0qai"];
    
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    
    blurView.frame = self.view.bounds;
    
    [self.view addSubview:blurView];

    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UICollectionView
- (PhotoBrowserCell *)cellForPage:(NSInteger)page{
    for (PhotoBrowserCell *cell in _cells) {
        if (cell.page == page) {
            return cell;
        }
    }
    return nil;
}

- (PhotoBrowserCell *)dequeueReusableCell{
    PhotoBrowserCell * cell = nil;
    for (cell in _cells) {
        if (!cell.superview) {
            return cell;
        }
    }
    
    cell = [PhotoBrowserCell new];
    cell.frame = self.view.bounds;
    cell.imageContainerView.frame = self.view.bounds;
    cell.imageView.frame = cell.bounds;
    cell.page = -1;
    cell.item = nil;
    [_cells addObject:cell];
    return cell;
}

- (void)setPhotoItems:(NSArray<PhotoBrowserItem *> *)photoItems {
    _photoItems = photoItems;
    
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (int i = 0; i<photoItems.count; i++) {
        
        PhotoBrowserCell *cell = [[PhotoBrowserCell alloc] init];
        
//        cell.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
        
    }
    
    for (PhotoBrowserItem *item in photoItems) {
        
        
    }
    
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
