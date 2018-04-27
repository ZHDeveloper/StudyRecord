//
//  EmoticonBoardView.m
//  EmotionKeyBoard
//
//  Created by ZhiHua Shen on 2018/4/25.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "EmoticonBoardView.h"
#import "InputToolViewModels.h"

NSString *const kEmoticonCellId = @"kEmoticonCellId";

#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

@interface EmoticonBoardView() <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray<EmotionModel *> *totalEmotions;

@end

@implementation EmoticonBoardView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.collectionView registerClass:[EmoticonBoardViewCell class] forCellWithReuseIdentifier:kEmoticonCellId];
    
    self.totalEmotions = [NSMutableArray arrayWithArray:EmotionModel.emotions];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.totalEmotions.count % 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    EmoticonBoardViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kEmoticonCellId forIndexPath:indexPath];

    NSRange range = NSMakeRange(indexPath.row * 20, 20);
    
    NSMutableArray *emotions = [NSMutableArray arrayWithArray:[self.totalEmotions subarrayWithRange:range]];
    
    EmotionModel *deleteModel = [[EmotionModel alloc] initWith:@"delete" png:@"DeleteEmoticonBtn_32x32_@2x"];
    
    [emotions addObject:deleteModel];
    
    cell.emotions = emotions;
    
    //表情点击事件
    [cell setEmotionClickBlock:^(EmotionModel *model) {
        [self.delegate emotionBoardView:self emotionDidClick:model];
    }];
    [cell setEmotionDeleteBlock:^{
        [self.delegate emotionBoardViewDidClickDelete:self];
    }];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.bounds.size;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.collectionView reloadData];
}

@end

@implementation EmoticonBoardViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        for (int i = 0; i<21; i++) {
            UIImageView *item = [[UIImageView alloc] init];
            item.tag = self.contentView.subviews.count;
            [self.contentView addSubview:item];
            
            item.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(emotionDidTap:)];
            [item addGestureRecognizer:tapGest];
        }
    }
    return self;
}

- (void)emotionDidTap:(UITapGestureRecognizer *)gest {
    UIView *view = gest.view;
    NSInteger tag = view.tag;
    if (tag == 20) {
        self.emotionDeleteBlock();
    }
    else {
        self.emotionClickBlock(self.emotions[tag]);
    }
}

- (void)setEmotions:(NSArray<EmotionModel *> *)emotions {
    _emotions = emotions;
    
    [emotions enumerateObjectsUsingBlock:^(EmotionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *item = self.contentView.subviews[idx];
        item.image = obj.image;
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat vieww = CGRectGetWidth(self.bounds);
    
    int rowCount = 7;
    
    CGFloat marginH = 18;
    CGFloat topMargin = 25;
    
    CGFloat itemW = 30;
    CGFloat itemH = 30;
    
    CGFloat marginX = (vieww - 16 - rowCount*itemW)/(rowCount+1);
    CGFloat leftMargin = marginX + 8;
    
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSUInteger row = idx / rowCount;
        int colum = idx % rowCount;
        
        CGFloat itemX = leftMargin + colum*(itemW + marginX);
        CGFloat itemY = topMargin + row * (itemH + marginH);
        obj.frame = CGRectMake(itemX, itemY, itemW, itemH);
    }];
}

@end
