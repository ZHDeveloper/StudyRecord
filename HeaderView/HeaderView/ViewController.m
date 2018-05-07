//
//  ViewController.m
//  HeaderView
//
//  Created by ZhiHua Shen on 2018/5/7.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "ViewController.h"
#import "FullscreenPopGesture.h"
#import "UIScrollView+HeaderView.h"

NSString *const kCellIdentify = @"kCellIdentify";

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.prefersNavigationBarHidden = YES;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    tableView.delegate = self;
    tableView.dataSource = self;
    _tableView = tableView;
    [self.view addSubview:tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentify];
    
    self.tableView.scaleImageHeight = 200;
    self.tableView.scaleImage = [UIImage imageNamed:@"large-web-banner"];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentify];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Demo--%d",indexPath.row];
    
    return cell;
}

@end
