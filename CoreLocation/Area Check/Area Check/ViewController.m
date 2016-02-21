//
//  ViewController.m
//  Area Check
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
    
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        [self.manager requestAlwaysAuthorization];
    }
    // 开始检测用户所在的区域
    // 创建中心点
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(40.058501, 116.304171);
    // 创建圆形区域, 指定区域中心点的经纬度, 以及半径
    CLCircularRegion *circluar = [[CLCircularRegion alloc] initWithCenter:center radius:500 identifier:@"软件园"];
    [self.manager stopMonitoringForRegion:circluar];
    
}
#pragma mark - CLLocationManagerDelegate
// 进入监听区域时调用
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSLog(@"进入监听区域时调用");
}
// 离开监听区域时调用
- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    NSLog(@"离开监听区域时调用");
}


@end
