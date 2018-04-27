//
//  Layer&AnimationVC.m
//  点滴记录
//
//  Created by ZhiHua Shen on 2018/4/10.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "Layer&AnimationVC.h"

@interface Layer_AnimationVC ()

@end

@implementation Layer_AnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0 ) {
        return @"图层";
    }
    else {
        return @"动画";
    }
}

@end
