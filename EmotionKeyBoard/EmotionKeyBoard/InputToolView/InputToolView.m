//
//  InputToolView.m
//  EmotionKeyBoard
//
//  Created by ZhiHua Shen on 2018/4/25.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "InputToolView.h"

typedef NS_ENUM(NSUInteger, InputToolViewType) {
    InputToolViewTypeKeyboard,
    InputToolViewTypeEmotion,
    InputToolViewTypeAddition,
};

@interface InputToolView() <UITextViewDelegate,EmoticonBoardViewDelegate,InputToolViewBarDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *barConstraintBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *barConstraintHeight;

@end

@implementation InputToolView

+ (instancetype)toolView {
    return [[NSBundle mainBundle] loadNibNamed:@"InputToolView" owner:nil options:nil].firstObject;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.eBoardView.delegate = self;
    self.toolBarView.delegate = self;
    
    //添加键盘的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.barConstraintBottom.constant = 0;
    [self layoutIfNeeded];
}

#pragma mark - KeyBoard
- (void)keyboardWillShow:(NSNotification *)notification {
    
    CGRect keyboardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.barConstraintBottom.constant = CGRectGetHeight(keyboardFrame);
        NSLog(@"%lf",self.barConstraintBottom.constant);
        NSLog(@"%lf",CGRectGetHeight(keyboardFrame));
        [self layoutIfNeeded];
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    [UIView animateWithDuration:0.25 animations:^{
        self.barConstraintBottom.constant = 0;
        [self layoutIfNeeded];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self resignInputView];
}

#pragma mark - EmoticonBoardViewDelegate
- (void)emotionBoardView:(EmoticonBoardView *)view emotionDidClick:(EmotionModel *)model {
    NSString *text = self.toolBarView.inputTextView.text;
    if (!text) {
        text = @"";
    }
    text = [text stringByAppendingString:model.chs];
    self.toolBarView.inputTextView.text = text;
}

- (void)emotionBoardViewDidClickDelete:(EmoticonBoardView *)view {
    [self.toolBarView deleteLastCharacter];
}

#pragma mark - Action
- (IBAction)emotionButtonAction:(UIButton *)sender {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [self showInputViewWith:InputToolViewTypeEmotion];
}

#pragma mark - InputToolViewBarDelegate
- (void)toolViewBar:(InputToolViewBar *)bar inputContentSizeChange:(UITextView *)textView {
    [UIView animateWithDuration:0.25 animations:^{
        CGFloat height = textView.contentSize.height;
        
        if (height >= self.inputViewMaxHeight) {
            self.barConstraintHeight.constant = self.inputViewMaxHeight + 16;
        }
        else {
            self.barConstraintHeight.constant = textView.contentSize.height + 16;
        }
        [self layoutIfNeeded];
    }];
}

- (CGFloat)inputViewMaxHeight {
    return self.toolBarView.inputViewMaxHeight;
}

- (void)setInputViewMaxHeight:(CGFloat)inputViewMaxHeight {
    self.toolBarView.inputViewMaxHeight = inputViewMaxHeight;
}

- (void)resignInputView {

    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];

    [UIView animateWithDuration:0.25 animations:^{
        self.barConstraintHeight.constant = 50;
        self.barConstraintBottom.constant = 0;
        [self layoutIfNeeded];
    }];
}

- (void)showInputViewWith:(InputToolViewType)type {
    
    if (type == InputToolViewTypeEmotion) {
        [self.layer removeAllAnimations];
        
        [self.eBoardView layoutIfNeeded];
        self.eBoardView.transform = CGAffineTransformMakeTranslation(0, 230);
        
        [UIView animateWithDuration:0.25 animations:^{
            self.eBoardView.transform = CGAffineTransformIdentity;
            self.barConstraintBottom.constant = 230;
            [self layoutIfNeeded];
        }];
    }
    else if (type == InputToolViewTypeAddition) {
        
    }
    else {
        
    }
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [self.delegate inputToolView:self sendText:textView.text];
        [self.toolBarView resetInputView];
        return NO;
    }
    return YES;
}

@end
