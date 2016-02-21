//
//  ViewController.m
//  CoreMotion
//
//  Created by Archy on 15/6/12.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()
@property (nonatomic, strong) CMMotionManager *manager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}
- (void)push
{
    self.manager = [[CMMotionManager alloc] init];
    
    if (self.manager.isAccelerometerAvailable)
    {
        /*
         isAccelerometerActive 是否正在采集
         accelerometerData 采集到得数据
         startAccelerometerUpdates  pull
         startAccelerometerUpdatesToQueue  push
         stopAccelerometerUpdates 停止采集
         accelerometerUpdateInterval 采样时间
         */

        self.manager.accelerometerUpdateInterval = 1/30.0;
        
        [self.manager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
        {
            if (error) return ;
            
            CMAcceleration acceleration = accelerometerData.acceleration;
            NSLog(@"x = %f y = %f z = %f", acceleration.x, acceleration.y , acceleration.z);
        }];
    }
    else
    {
        NSLog(@"加速计不可用");
    }
}

- (void)pull
{
    self.manager = [[CMMotionManager alloc] init];
    
    if (self.manager.isAccelerometerAvailable)
    {
        [self.manager startAccelerometerUpdates]; //pull
    }
    else
    {
        NSLog(@"加速计不可用");
    }

}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CMAcceleration acceleration = self.manager.accelerometerData.acceleration;
    
    NSLog(@"x = %f y = %f z = %f", acceleration.x, acceleration.y , acceleration.z);
}

@end
