//
//  ViewController.m
//  SingleTon
//
//  Created by Archy on 15/6/2.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    Student *stu = [Student sharedStudent];
    
}

@end
