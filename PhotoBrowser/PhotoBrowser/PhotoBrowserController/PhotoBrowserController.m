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

@end

@implementation PhotoBrowserController

+ (instancetype)browserWithSelectedIndex:(NSInteger)index phothItems:(NSArray<PhotoBrowserItem *> *)photoItems fromView:(UIView *)fromView {

    PhotoBrowserController *browserVC = [[UIStoryboard storyboardWithName:@"PhotoBrowser" bundle:nil] instantiateInitialViewController];
    
    browserVC.currentIndex = index;
    browserVC.photoItems = photoItems;
    browserVC.animator = [[PhotoBrowserAnimator alloc] initWith:fromView];

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
    
    self.bgImage = [UIImage imageNamed:@"72635b6agw1eyqehvujq1j218g0p0qai"];
    
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
        
        [self.scrollView addSubview:cell];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UICollectionView
- (void)setPhotoItems:(NSArray<PhotoBrowserItem *> *)photoItems {
    _photoItems = photoItems;

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
