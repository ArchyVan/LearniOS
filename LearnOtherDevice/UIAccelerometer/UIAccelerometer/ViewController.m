//
//  ViewController.m
//  UIAccelerometer
//
//  Created by Archy on 15/6/12.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Extension.h"
@interface ViewController ()<UIAccelerometerDelegate>

@property (nonatomic, strong) UIImageView *imageBall;
@property (nonatomic, assign) CGPoint velocity;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 1.利用单例获取采集对象
    
    _imageBall = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _imageBall.backgroundColor = [UIColor redColor];
    _imageBall.layer.masksToBounds = YES;
    _imageBall.layer.cornerRadius = 50;
    
    [self.view addSubview:_imageBall];
    
    UIAccelerometer *acc = [UIAccelerometer sharedAccelerometer];
    acc.delegate = self;
    acc.updateInterval = 1 / 30;
    
}
- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    NSLog(@"x = %f / y = %f / z = %f ",acceleration.x,acceleration.y,acceleration.z);
    
    _velocity.x += acceleration.x;
    // -=的原因是因为获取到得Y轴的加速度和UIKit的坐标系的Y的值是相反的, 而我们将来想让小球往加速度的反方向运动, 所以 -=;
    _velocity.y -= acceleration.y;
    
    self.imageBall.x += _velocity.x;
    self.imageBall.y += _velocity.y;
    
    // 边界检测
    if (self.imageBall.x <= 0) {
        // 矫正小球当前的位置
        self.imageBall.x = 0;
        // 超出了屏幕的左边
        _velocity.x *= -0.5;
    }
    if (self.imageBall.y <= 0) {
        // 矫正小球当前的位置
        self.imageBall.y = 0;
        // 超出屏幕的顶部
        _velocity.y *= -0.5;
    }
    
    if (CGRectGetMaxY(self.imageBall.frame) >= self.view.height) {
        // 矫正小球当前的位置
        self.imageBall.y = self.view.height - self.imageBall.height;
        // 查出屏幕的底部
        _velocity.y *= -0.5;
    }
    
    if (CGRectGetMaxX(self.imageBall.frame) >= self.view.width) {
        // 矫正小球当前的位置
        self.imageBall.x = self.view.width - self.imageBall.width;
        // 查出屏幕的右边
        _velocity.x *= -0.5;
    }
    
}


@end
