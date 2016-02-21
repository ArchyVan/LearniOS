//
//  ViewController.m
//  CircleProgress
//
//  Created by Archy on 15/6/14.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"

#import "ProgressView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet ProgressView *progressView;

@end

@implementation ViewController
- (IBAction)valueChange:(UISlider *)sender {
    
    _progressView.progress = sender.value;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
