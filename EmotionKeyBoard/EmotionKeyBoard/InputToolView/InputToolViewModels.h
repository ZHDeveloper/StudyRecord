//
//  Model.h
//  EmotionKeyBoard
//
//  Created by ZhiHua Shen on 2018/4/25.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmotionModel : NSObject

@property (class,nonatomic,strong,readonly) NSArray<EmotionModel *> *emotions;
@property (class,nonatomic,strong,readonly) YYTextSimpleEmoticonParser *emotionMapper;

@property (nonatomic,copy) NSString *chs;

@property (nonatomic,copy) NSString *png;

@property (nonatomic,strong) UIImage *image;

- (instancetype)initWith:(NSString *)chs png:(NSString *)png;

@end

@interface TextAttachment : NSTextAttachment

@property(assign, nonatomic) CGSize size;  //For emoji image size

- (instancetype)initWith:(UIImage *)image size:(CGSize)size;

@end
