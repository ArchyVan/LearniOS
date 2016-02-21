//
//  ViewController.m
//  AnimationGroup
//
//  Created by Archy on 15/6/14.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) UIView *redView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CABasicAnimation *rotation = [CABasicAnimation animation];
    
    rotation.keyPath = @"transform.rotation";
    
    rotation.toValue = @M_PI_2;
    
    CABasicAnimation *position = [CABasicAnimation animation];
    
    position.keyPath = @"position";
    
    position.toValue = [NSValue valueWithCGPoint:CGPointMake(100, 250)];
    
    CABasicAnimation *scale = [CABasicAnimation animation];
    
    scale.keyPath = @"transform.scale";
    
    scale.toValue = @0.5;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[rotation,position,scale];
    
    group.duration = 2;
    
    group.removedOnCompletion = NO;
    
    group.fillMode = kCAFillModeForwards;
    
    [_redView.layer addAnimation:group forKey:nil];
}

@end
