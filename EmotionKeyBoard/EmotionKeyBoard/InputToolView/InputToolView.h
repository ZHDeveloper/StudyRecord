//
//  InputToolView.h
//  EmotionKeyBoard
//
//  Created by ZhiHua Shen on 2018/4/25.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmoticonBoardView.h"
#import "InputToolViewBar.h"
#import "InputToolViewModels.h"

@class InputToolView;
@protocol InputToolViewDelegate

- (void)inputToolView:(InputToolView *)view sendText:(NSString *)text;

@end

@interface InputToolView : UIView

@property (nonatomic,assign) CGFloat inputViewMaxHeight;
@property (nonatomic,weak) id<InputToolViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet InputToolViewBar *toolBarView;
@property (weak, nonatomic) IBOutlet EmoticonBoardView *eBoardView;

+ (instancetype)toolView;

@end
