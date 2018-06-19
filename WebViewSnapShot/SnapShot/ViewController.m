//
//  ViewController.m
//  SnapShot
//
//  Created by ZhiHua Shen on 2018/6/19.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController () <UIWebViewDelegate,WKNavigationDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *uiWebView;

@property (weak, nonatomic) IBOutlet WKWebView *wkWebView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.qihuofy.com/"]];

    if (self.uiWebView) {
        [self.uiWebView loadRequest:request];
    }
    else {
        [self.wkWebView loadRequest:request];
        self.wkWebView.navigationDelegate = self;
    }
}

#pragma mark - UIWebView
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"%s",__func__);
    
    UIImage *img = [self snapshotForScrollView:webView.scrollView];
    UIImageWriteToSavedPhotosAlbum(img, nil, nil, NULL);
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}

- (UIImage *)snapshotForScrollView:(UIScrollView *)scrollView {
    
    CGPoint currentOffset = scrollView.contentOffset;
    CGRect currentFrame = scrollView.frame;
    
    scrollView.contentOffset = CGPointZero;
    scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
    
    UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, YES, 0);
    [scrollView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    scrollView.contentOffset = currentOffset;
    scrollView.frame = currentFrame;
    
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return snapshotImage;
}

#pragma mark - WKWebView
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"开始截图");
    [self snapshotForWKWebView:webView];
}

- (void)snapshotForWKWebView:(WKWebView *)webView {
    
    [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.25]];
    
    // 资源加载
    UIScrollView *scrollView = webView.scrollView;
    CGSize pageSize = scrollView.contentSize;
    CGRect bounds = webView.bounds;
    CGPoint currentOffset = scrollView.contentOffset;
    CGFloat horizontalLimit = ceil(pageSize.width/scrollView.frame.size.width);
    CGFloat verticalLimit = ceil(pageSize.height/scrollView.frame.size.height);
    
    for (int i = 0; i<=verticalLimit; i++) {
        for (int j = 0; j<=horizontalLimit; j++) {
            [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.size.width * j, scrollView.frame.size.height * i, scrollView.frame.size.width, scrollView.frame.size.width) animated:true];
            [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.25]];
        }
    }
    
    // 图片渲染
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIGraphicsBeginImageContextWithOptions(pageSize, NO, 0);
        
        webView.bounds = CGRectMake(0, 0, pageSize.width, pageSize.height);
        
        [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
        
        [webView.layer renderInContext:UIGraphicsGetCurrentContext()];
        
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        webView.bounds = bounds;
        
        UIImageWriteToSavedPhotosAlbum(img, nil, nil, NULL);
        
        [scrollView setContentOffset:currentOffset animated:false];
    });
}

@end
