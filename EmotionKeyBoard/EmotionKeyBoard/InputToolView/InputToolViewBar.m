//
//  InputToolViewBar.m
//  EmotionKeyBoard
//
//  Created by ZhiHua Shen on 2018/4/25.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "InputToolViewBar.h"

@implementation InputToolViewBar

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self addObserver:self forKeyPath:@"self.inputTextView.contentSize" options:NSKeyValueObservingOptionNew context:nil];
    
    self.inputViewMaxHeight = 80;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if (object != self || [keyPath isEqualToString:@"self.textView.contentSize"]) { return; }
    
    if (self.inputTextView.text.length == 0) { return; }

    [self.delegate toolViewBar:self inputContentSizeChange:self.inputTextView];
    
    //设置间距
    CGFloat inputH = self.inputTextView.bounds.size.height;
    CGFloat maxH = self.inputViewMaxHeight;
    
    if (( inputH >= maxH - 1)&&(inputH <= maxH + 1)) {
        self.inputTextView.contentInset = UIEdgeInsetsMake(0, 0, 4, 0);
    }
    else {
        self.inputTextView.contentInset = UIEdgeInsetsZero;
    }
    //
    CGPoint bottomOffset = CGPointMake(0.0f, self.inputTextView.contentSize.height-self.inputTextView.bounds.size.height);
    [self.inputTextView setContentOffset:bottomOffset animated:NO];
    [self.inputTextView scrollRangeToVisible:NSMakeRange(self.inputTextView.text.length-2, 1)];
}

- (void)resetInputView {
    self.inputTextView.text = nil;
    self.inputTextView.contentInset = UIEdgeInsetsZero;
}

- (void)deleteLastCharacter {
    
    if (!self.inputTextView.text || self.inputTextView.text.length == 0) { return; }
    
    NSString *text = self.inputTextView.text;
    
    if ([self isEmotionInLastCharacter]) {
        NSRange startRang = [text rangeOfString:@"[" options:NSBackwardsSearch];
        NSString *subText = [text substringToIndex:startRang.location];
        self.inputTextView.text = subText;
    }
    else {
        self.inputTextView.text = [text substringToIndex:text.length-1];
    }
}

- (BOOL)isEmotionInLastCharacter {
    NSString *text = self.inputTextView.text;
    return [text containsString:@"["] &&  [text containsString:@"]"] && [[text substringFromIndex:text.length - 1] isEqualToString:@"]"];
}

@end
