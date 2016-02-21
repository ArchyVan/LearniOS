//
//  ViewController.m
//  Compass
//
//  Created by Archy on 15/6/16.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()<CLLocationManagerDelegate>
/**
 *  定位管理者
 */
@property (nonatomic, strong) CLLocationManager *manager;
/**
 *  指南针
 */
@property (nonatomic, weak) UIImageView *compasspointer;

@end

@implementation ViewController

- (CLLocationManager *)manager
{
    if (!_manager) {
        _manager = [[CLLocationManager alloc] init];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_compasspointer-1"]];
    
    imageView.center = self.view.center;
    
    [self.view addSubview:imageView];
    
    self.compasspointer = imageView;
    
    self.manager.delegate = self;
    
    [self.manager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    /*
     magneticHeading 设备与磁北的相对角度
     trueHeading 设置与真北的相对角度, 必须和定位一起使用, iOS需要设置的位置来计算真北
     真北始终指向地理北极点
     */
    // 1.将获取到的角度转为弧度 = (角度 * π) / 180;
    CGFloat angle = newHeading.magneticHeading * M_PI / 180;
    /*
     顺时针 正
     逆时针 负数
     */
    self.compasspointer.transform = CGAffineTransformMakeRotation(-angle);
}

@end
