//
//  ViewController.m
//  PhotoGroupView
//
//  Created by ZhiHua Shen on 2018/5/3.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "ViewController.h"
#import "YYPhotoGroupView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    YYPhotoGroupItem *item = [[YYPhotoGroupItem alloc] init];
    item.largeImageURL = [NSURL URLWithString:@"http://pic.58pic.com/58pic/12/96/26/79W58PICYKg.jpg"];
    
    YYPhotoGroupView *groupView = [[YYPhotoGroupView alloc] initWithGroupItems:@[item]];
    
    [groupView presentFromImageView:nil toContainer:self.view animated:YES completion:nil];
}


@end
