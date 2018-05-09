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
    
    YYPhotoGroupItem *item1 = [[YYPhotoGroupItem alloc] init];
    item1.largeImageURL = [NSURL URLWithString:@"http://pic.58pic.com/58pic/12/96/26/79W58PICYKg.jpg"];
    
    YYPhotoGroupItem *item2 = [[YYPhotoGroupItem alloc] init];
    item2.largeImageURL = [NSURL URLWithString:@"http://pic.58pic.com/58pic/12/96/26/79W58PICYKg.jpg"];
    
    YYPhotoGroupItem *item3 = [[YYPhotoGroupItem alloc] init];
    item3.largeImageURL = [NSURL URLWithString:@"http://pic.58pic.com/58pic/12/96/26/79W58PICYKg.jpg"];
    
    YYPhotoGroupView *groupView = [[YYPhotoGroupView alloc] initWithGroupItems:@[item1,item2,item3]];
    
    [groupView presentFromImageView:nil toContainer:self.view animated:YES completion:nil];
}


@end
