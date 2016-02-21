//
//  ViewController.m
//  Wheel
//
//  Created by Archy on 15/5/22.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"
#import "WheelView.h"

@interface ViewController ()

@property (nonatomic, weak) WheelView *wheelView;

@end

@implementation ViewController
- (IBAction)start {
    [_wheelView startRotating];
}
- (IBAction)stop {
    [_wheelView stopRotating];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    WheelView *wheel = [WheelView wheelView];
    
    wheel.center = self.view.center;
    
    [self.view addSubview:wheel];
    
    _wheelView = wheel;
}


@end
