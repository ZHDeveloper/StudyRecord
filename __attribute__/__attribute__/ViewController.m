//
//  ViewController.m
//  __attribute__
//
//  Created by ZhiHua Shen on 2018/6/6.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

__attribute__((overloadable)) void just(int num){
    NSLog(@"just Int %i",num);
}

__attribute__((overloadable)) void just(NSString * num){
    NSLog(@"just NSString %@",num);
}

__attribute__((overloadable)) void just(NSNumber * num){
    NSLog(@"just NSNumber %@",num);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /// http://releases.llvm.org/3.8.0/tools/clang/docs/AttributeReference.html#assume-aligned-gnu-assume-aligned
    
    Person *person __attribute__((cleanup(clean))) = [[Person alloc] initWith:@"张三"];
    NSLog(@"%@",person.name);
    
    [person work];
    [person run];
    [person doRun];
    
    just(10);
    
    NSString *strIDFV = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSLog(@"%@",strIDFV);
    
    Student *st = [[Student alloc] initWith:@"李四"];
    NSLog(@"%@",[st class]);
    
    HMStudent *hst __attribute__((unused)) = [[HMStudent alloc] initWith:@"龙武"];
    
}

void clean(__strong Person **p) {
    Person *person = *p;
    NSLog(@"%@",person.name);
}

@end
