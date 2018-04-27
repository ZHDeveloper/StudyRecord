//
//  ViewController.m
//  EmotionKeyBoard
//
//  Created by ZhiHua Shen on 2018/4/24.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "ViewController.h"
#import "InputToolView.h"

static NSString *kReuseId = @"messageId";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,InputToolViewDelegate> {
    InputToolView *_toolView;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [NSMutableArray array];

    _toolView = [InputToolView toolView];
    _toolView.delegate = self;
    [self.view addSubview:_toolView];
    
    [self.tableView registerClass:[MessageCell class] forCellReuseIdentifier:kReuseId];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    
//    UIFont *font = [UIFont systemFontOfSize:20];
    
//    UIImage *image = [UIImage imageNamed:@"Expression_95@2x.png"];
//    TextAttachment *attachment = [[TextAttachment alloc] initWith:image size:CGSizeMake(font.pointSize, font.pointSize)];
//
//    NSAttributedString *str = [NSAttributedString attributedStringWithAttachment:attachment];
    
//    YYTextSimpleEmoticonParser *parser = [YYTextSimpleEmoticonParser new];
//    parser.emoticonMapper = EmotionModel.emotionMapper;

//    self.label.textParser = parser;
    
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    [_toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseId forIndexPath:indexPath];

    cell.label.text = self.dataSource[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

#pragma mark - InputToolViewDelegate
- (void)inputToolView:(InputToolView *)view sendText:(NSString *)text {
    [self.dataSource addObject:text];
    [self.tableView reloadData];
}

@end

@implementation MessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.label = [YYLabel new];
        self.label.textParser = EmotionModel.emotionMapper;
        [self.contentView addSubview:self.label];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.label.frame = self.bounds;
}

//- (void)updateConstraints {
//    [super updateConstraints];
//    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self);
//    }];
//}

@end
