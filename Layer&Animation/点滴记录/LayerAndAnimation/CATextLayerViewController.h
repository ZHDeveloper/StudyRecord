//
//  CATextLayerViewController.h
//  点滴记录
//
//  Created by ZhiHua Shen on 2018/4/10.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CATextLayerViewController : UIViewController

@end

@interface LayerLabel: UIView

@property (nonatomic,strong,readonly) CATextLayer *textlayer;

@property (nonatomic,copy) NSString *text;

@property (nonatomic,strong) UIFont *font;

@end
