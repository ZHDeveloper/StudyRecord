//
//  EmoticonBoardView.h
//  EmotionKeyBoard
//
//  Created by ZhiHua Shen on 2018/4/25.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EmotionModel,EmoticonBoardView;

@protocol EmoticonBoardViewDelegate

- (void)emotionBoardView:(EmoticonBoardView *)view emotionDidClick:(EmotionModel *)model;
- (void)emotionBoardViewDidClickDelete:(EmoticonBoardView *)view;

@end

@interface EmoticonBoardView : UIView

@property (nonatomic,weak) id<EmoticonBoardViewDelegate> delegate;

@end

@interface EmoticonBoardViewCell: UICollectionViewCell

@property (nonatomic,strong) NSArray<EmotionModel *> *emotions;

@property (nonatomic,copy) void (^emotionClickBlock)(EmotionModel *);
@property (nonatomic,copy) void (^emotionDeleteBlock)(void);


@end
