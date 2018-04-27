//
//  ViewController.m
//  点滴记录
//
//  Created by ZhiHua Shen on 2018/4/10.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"点滴记录";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

@end
