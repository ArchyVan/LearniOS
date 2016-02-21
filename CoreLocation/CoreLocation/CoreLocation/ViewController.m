//
//  ViewController.m
//  CoreLocation
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
    // Do any additional setup after loading the view, typically from a nib.
    self.manager.delegate = self;
    
    self.manager.distanceFilter = 10;
    
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0 ) {
        NSLog(@"It's 8.0");
        
        [self.manager requestAlwaysAuthorization];
    } else {
    
        NSLog(@"It's 7.0");
        [self.manager startUpdatingLocation];
    }
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"%s",__func__);
    
    CLLocation *location = [locations lastObject];
    /*
     location.coordinate; 坐标, 包含经纬度
     location.altitude; 设备海拔高度 单位是米
     location.course; 设置前进方向 0表示北 90东 180南 270西
     location.horizontalAccuracy; 水平精准度
     location.verticalAccuracy; 垂直精准度
     location.timestamp; 定位信息返回的时间
     location.speed; 设备移动速度 单位是米/秒, 适用于行车速度而不太适用于不行
     */
    NSLog(@"%f, %f speed = %f", location.coordinate.latitude , location.coordinate.longitude, location.speed);
}
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusNotDetermined) {
        NSLog(@"等待用户授权");
    } else if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        NSLog(@"授权成功");
        
        [self.manager startUpdatingLocation];
    } else {
        NSLog(@"授权失败");
    }
}



@end
