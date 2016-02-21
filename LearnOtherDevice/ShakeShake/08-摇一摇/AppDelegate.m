//
//  AppDelegate.m
//  08-摇一摇
//
//  Created by apple on 14/11/5.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

/**
 *  开始摇晃就会调用
 */
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"%s", __func__);
}
/**
 *  摇晃结束就会调用
 */
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
     NSLog(@"%s", __func__);
}
/**
 *  摇晃被打断就会调用
 */
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
     NSLog(@"%s", __func__);
}

@end
