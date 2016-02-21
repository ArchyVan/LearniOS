//
//  ViewController.m
//  Car Navigation
//
//  Created by Archy on 15/6/16.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>

// 创建定位管理者
@property (nonatomic, strong) CLLocationManager *manager;
// 上一次的位置
@property (nonatomic, strong) CLLocation *previousLocation;
// 总路程
@property (nonatomic, assign) CLLocationDistance sumDistance;
// 总时间
@property (nonatomic, assign) NSTimeInterval sumTime;
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
    
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        [self.manager requestAlwaysAuthorization];
    }
    [self.manager startUpdatingLocation];
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //    CLLocation; timestamp 当前获取到为止信息的时间
    /*
     获取走了多远（这一次的位置 减去上一次的位置）
     获取走这段路花了多少时间 （这一次的时间 减去上一次的时间）
     获取速度 （走了多远 ／ 花了多少时间）
     获取总共走的路程 （把每次获取到走了多远累加起来）
     获取平均速度 （用总路程 ／ 总时间）
     */
    // 获取当前的位置

    CLLocation *newLocation = [locations lastObject];
    
    if (self.previousLocation != nil) {
        // 计算两次的距离(单位时米)
        CLLocationDistance distance = [newLocation distanceFromLocation:self.previousLocation];
        // 计算两次之间的时间（单位只秒）
        NSTimeInterval durationTime = [newLocation.timestamp timeIntervalSinceDate:self.previousLocation.timestamp];
        // 计算速度（米／秒）
        CGFloat speed = distance / durationTime;
        // 累加时间
        self.sumTime += durationTime;
        // 累加距离
        self.sumDistance += distance;
        //  计算平均速度
        CGFloat avgSpeed = self.sumDistance / self.sumTime;
        
        NSLog(@"距离%f 时间%f 速度%f 平均速度%f 总路程 %f 总时间 %f", distance, durationTime, speed, avgSpeed, self.sumDistance, self.sumTime);

    }
    // 纪录上一次的位置
    self.previousLocation = newLocation;

}



@end
