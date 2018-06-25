//
//  MainViewController.m
//  XCConfig
//
//  Created by ZhiHua Shen on 2018/6/25.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.button setTitle:[self infoForKey:@"Button_Title"] forState:UIControlStateNormal];
}

- (NSString *)infoForKey:(NSString *)key {
    return [NSBundle mainBundle].infoDictionary[key];
}

@end
