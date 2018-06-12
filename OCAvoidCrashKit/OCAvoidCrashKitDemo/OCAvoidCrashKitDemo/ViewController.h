//
//  ViewController.h
//  OCAvoidCrashKitDemo
//
//  Created by ZhiHua Shen on 2018/6/5.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Person;
@interface ViewController : UIViewController

- (Person *)test;

@end

@interface Person: NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) int age;

- (void)test;

@end


