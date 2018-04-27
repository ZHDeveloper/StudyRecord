//
//  InputToolViewBar.h
//  EmotionKeyBoard
//
//  Created by ZhiHua Shen on 2018/4/25.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InputToolViewBar;
@protocol InputToolViewBarDelegate

- (void)toolViewBar:(InputToolViewBar *)bar inputContentSizeChange:(UITextView *)textView;

@end

@interface InputToolViewBar : UIView

@property (nonatomic,weak) id<InputToolViewBarDelegate> delegate;

@property (nonatomic,assign) CGFloat inputViewMaxHeight;

@property (weak, nonatomic) IBOutlet UITextView *inputTextView;

- (void)resetInputView;

- (void)deleteLastCharacter;

@end
