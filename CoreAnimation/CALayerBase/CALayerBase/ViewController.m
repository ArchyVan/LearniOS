//
//  ViewController.m
//  CALayerBase
//
//  Created by Archy on 15/6/14.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) UIView *redView;
@property (weak, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) CALayer *layer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    redView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:redView];
    self.redView = redView;
    [self viewLayer];

}

- (void)configLayer
{
    CALayer *layer = [CALayer layer];
    
    layer.bounds = CGRectMake(0, 0, 100, 100);
    
    layer.backgroundColor = [UIColor redColor].CGColor;
    
    [self.view.layer addSublayer:layer];
    
    _layer = layer;
    
//    [self viewLayer];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    CGPoint pos = [touch locationInView:self.view];
    
    [CATransaction begin];
    
    [CATransaction setDisableActions:YES];
    
    _layer.position = CGPointMake(100, 100);
    
    _layer.borderWidth = arc4random_uniform(5) + 1;
    
    CGFloat r = arc4random_uniform(256) / 255.0;
    CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    
    _layer.borderColor = [UIColor colorWithRed:r green:g blue:b alpha:1].CGColor;
    
    _layer.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1].CGColor;
    
    _layer.position = pos;
    
    [CATransaction commit];
}
- (void)customLayer
{
    CALayer *layer = [CALayer layer];
    
    layer.bounds = CGRectMake(0, 0, 100, 100);
    
    layer.position = CGPointMake(100, 100);
    
    layer.backgroundColor = [UIColor redColor].CGColor;
    
    layer.contents = (__bridge id)([UIImage imageNamed:@"image"].CGImage);
    
    [self.view.layer addSublayer:layer];
}

- (void)imageViewLayerTransform
{
    [UIView animateWithDuration:1 animations:^{
       
        _imageView.layer.transform = CATransform3DMakeRotation(M_PI, 1, 1, 0);
        
        _imageView.layer.transform = CATransform3DMakeScale(1, 0.5, 1);
        
        _imageView.layer.transform = CATransform3DMakeTranslation(200, 200, 10);
        
        //利用KVC改变形变
        
        NSValue *rotation = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 1, 1, 0)];
        
        [_imageView.layer setValue:rotation forKeyPath:@"transform"];
        
        [_imageView setValue:@M_PI forKeyPath:@"transform.rotation"];
        
        [_imageView.layer setValue:@0.5 forKeyPath:@"transform.scale"];
        
        [_imageView.layer setValue:@200 forKeyPath:@"transform.translatin.x"];
        
    }];
}

- (void)imageViewLayer
{
    _imageView.layer.cornerRadius = 50;
    
    _imageView.layer.masksToBounds = YES;
    
    _imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    _imageView.layer.borderWidth = 2;
}

- (void)viewLayer
{
    _redView.layer.shadowOpacity = 1;
    
    _redView.layer.shadowColor = [UIColor blackColor].CGColor;
    
    _redView.layer.shadowRadius = 10;
    
    _redView.layer.shadowOffset = CGSizeMake(0, 50);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(50, 50) radius:50 startAngle:0 endAngle:(M_PI ) clockwise:YES];
    _redView.layer.shadowPath = path.CGPath;
    
//    _redView.layer.cornerRadius = 50;
//    
//    _redView.layer.borderColor = [UIColor whiteColor].CGColor;
//    
//    _redView.layer.borderWidth = 2;
    
}

@end
