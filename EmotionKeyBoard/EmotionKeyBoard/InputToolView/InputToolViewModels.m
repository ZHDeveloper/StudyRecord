//
//  Model.m
//  EmotionKeyBoard
//
//  Created by ZhiHua Shen on 2018/4/25.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "InputToolViewModels.h"

@implementation EmotionModel

static NSArray<EmotionModel *> *_emotions;
static YYTextSimpleEmoticonParser *_emotionMapper;

- (instancetype)initWith:(NSString *)chs png:(NSString *)png {
    if ([super init]) {
        self.chs = chs;
        self.png = png;
    }
    return self;
}

- (void)setPng:(NSString *)png {
    _png = png;
    self.image = [UIImage imageNamed:[png stringByAppendingString:@".png"]];
}

+ (NSArray<EmotionModel *> *)emotions {
    if (!_emotions) {
        NSString *file = [[NSBundle mainBundle] pathForResource:@"Expression.plist" ofType:nil];
        NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:file];
        _emotions = [EmotionModel mj_objectArrayWithKeyValuesArray:array];
    }
    return _emotions;
}

+ (YYTextSimpleEmoticonParser *)emotionMapper {
    if (!_emotionMapper) {
        YYTextSimpleEmoticonParser *parser = [YYTextSimpleEmoticonParser new];
        NSMutableDictionary *mapper = [NSMutableDictionary dictionary];
        for (EmotionModel *model in EmotionModel.emotions) {
            mapper[model.chs] = model.image;
        }
        parser.emoticonMapper = mapper;
        _emotionMapper = parser;
    }
    return _emotionMapper;
}

@end


@implementation TextAttachment

- (instancetype)initWith:(UIImage *)image size:(CGSize)size {
    if ([super init]) {
        self.image = image;
        self.size = size;
    }
    return self;
}

- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex {
    return CGRectMake(0, 0, self.size.width, self.size.height);
}

@end
