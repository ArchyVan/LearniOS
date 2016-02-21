//
//  AnimationViewController.m
//  CALayerBase
//
//  Created by Archy on 15/6/14.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "AnimationViewController.h"

@interface AnimationViewController ()

@property (nonatomic, weak) CALayer *layer;

@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CALayer *layer = [CALayer layer];
    
    layer.position = CGPointMake(100, 100);
    
    layer.bounds = CGRectMake(0, 0, 100, 100);
    
    layer.backgroundColor = [UIColor redColor].CGColor;
    
    layer.contents = (__bridge id)([UIImage imageNamed:@"image"].CGImage);
    
    [self.view.layer addSublayer:layer];
    
    _layer = layer;
    
}

- (void)keyPathAnimation
{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    
    anim.keyPath = @"position";
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 200, 200)];
    
    anim.path = path.CGPath;
    
    anim.duration = 0.25;
    
    anim.removedOnCompletion = NO;
    
    anim.fillMode = kCAFillModeForwards;
    
    anim.repeatCount = MAXFLOAT;
    
    [_layer addAnimation:anim forKey:nil];
}
- (void)keyValueAnimation
{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    
    anim.keyPath = @"position";
    
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointZero];
    
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(160, 160)];
    
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(270, 0)];
    
    anim.values = @[value1,value2,value3];
    
    anim.duration = 2;
    
    [_layer addAnimation:anim forKey:nil];
}
- (void)scale
{
    CABasicAnimation *anim = [CABasicAnimation animation];
    
    anim.keyPath = @"transform.scale";
    
    anim.toValue = @0.5;
    
    anim.duration = 0.25;
    
    anim.removedOnCompletion = NO;
    
    anim.fillMode = kCAFillModeForwards;
    
    anim.repeatCount = MAXFLOAT;
    
    [_layer addAnimation:anim forKey:nil];
}
- (void)position
{
    
    CABasicAnimation *anim = [CABasicAnimation animation];
    
    anim.keyPath = @"position";
    
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    
    anim.duration = 2;
    
    anim.removedOnCompletion = NO;
    
    anim.fillMode = kCAFillModeForwards;
    
    [_layer addAnimation:anim forKey:nil];
}


@end
