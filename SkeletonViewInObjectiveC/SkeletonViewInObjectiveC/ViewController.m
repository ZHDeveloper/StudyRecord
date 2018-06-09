//
//  ViewController.m
//  ABC
//
//  Created by ZhiHua Shen on 2018/5/28.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "ViewController.h"
#import "UIView+SkeletonView.h"

@interface ViewController ()<SkeletonTableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic,strong) NSMutableArray *array;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.array = [NSMutableArray array];
    
    self.tableView.rowHeight = 120;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView showAnimatedSkeleton];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.array addObjectsFromArray:@[@"1",@"2",@"3"]];
        [self.tableView hideSkeletonWithReloadDataAfter:YES];
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (NSString *)collectionSkeletonView:(UITableView *)skeletonView cellIdenfierForRowAt:(NSIndexPath *)indexPath {
    return @"DemoCell";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DemoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DemoCell"];
    cell.titleL.text = @"----";
    return cell;
}

@end


@implementation DemoCell

@end



