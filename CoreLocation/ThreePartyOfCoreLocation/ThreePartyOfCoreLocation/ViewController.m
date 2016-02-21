//
//  ViewController.m
//  ThreePartyOfCoreLocation
//
//  Created by Archy on 15/6/17.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"
#import "INTULocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)INTULocationManagerRequest
{
    INTULocationManager *manager = [INTULocationManager sharedInstance];
    
    [manager requestLocationWithDesiredAccuracy:INTULocationAccuracyRoom timeout:5 delayUntilAuthorized:YES block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
        
        if (status == INTULocationStatusSuccess) {
            NSLog(@"获取位置成功 %f %f", currentLocation.coordinate.latitude , currentLocation.coordinate.longitude);
        } else if (status == INTULocationStatusError)
        {
            NSLog(@"获取失败");
        }
        
    }];
}
@end
