//
//  SecondViewController.m
//  BackButtonHandler
//
//  Created by ZhiHua Shen on 2018/5/3.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "SecondViewController.h"
#import "UIViewController+BackButtonHandler.h"

@interface SecondViewController () <BackButtonHandlerProtocol>

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(BOOL)navigationShouldPopOnBackButton {
    
    return YES;
}

@end
