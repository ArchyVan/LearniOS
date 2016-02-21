//
//  ViewController.m
//  BaseGraph
//
//  Created by Archy on 15/6/13.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"
#import "LineView.h"
#import "ShapeView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    LineView *line = [[LineView alloc] initWithFrame:CGRectMake(10, 100, 355, 355)];
//    
//    line.backgroundColor = [UIColor whiteColor];
//    
//    [self.view addSubview:line];
    
    ShapeView *shape = [[ShapeView alloc] initWithFrame:CGRectMake(65, 100, 250, 250)];
    
    shape.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:shape];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
