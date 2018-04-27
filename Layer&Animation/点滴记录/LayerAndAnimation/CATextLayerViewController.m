//
//  CATextLayerViewController.m
//  点滴记录
//
//  Created by ZhiHua Shen on 2018/4/10.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "CATextLayerViewController.h"

@interface CATextLayerViewController ()

@end

@implementation CATextLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LayerLabel *label = [[LayerLabel alloc] init];
    label.frame = CGRectMake(SCREEN_WIDTH*0.5 - 100, SCREENH_HEIGHT*0.5 - 100, 200, 200);
    label.font = [UIFont systemFontOfSize:15];
    
    label.text = @"小爱同学是小米公司于2017年7月26日发布的首款人工智能（AI）音箱的唤醒词及二次元人物形象，音箱售价299元，2017年8月将开启公测，9月26日正式开售。";
    [self.view addSubview:label];
}

@end

@implementation LayerLabel

+ (Class)layerClass {
    return [CATextLayer class];
}

- (CATextLayer *)textlayer {
    return (CATextLayer *)self.layer;
}

- (void)setText:(NSString *)text {
    self.textlayer.string = text;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.textlayer.wrapped = YES;
        self.textlayer.truncationMode = @"end";
        self.textlayer.contentsScale = [UIScreen mainScreen].scale;
        self.textlayer.backgroundColor = [UIColor whiteColor].CGColor;
        self.textlayer.foregroundColor = [UIColor redColor].CGColor;
        
        [self.textlayer display];
    }
    return self;
}

- (void)setFont:(UIFont *)font {
    
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef cgfont = CGFontCreateWithFontName(fontName);
    
    self.textlayer.font = cgfont;
    self.textlayer.fontSize = font.pointSize;
    
    CGFontRelease(cgfont);
}

@end
