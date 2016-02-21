//
//  ViewController.m
//  LocalNotification
//
//  Created by Archy on 15/6/19.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)addNote
{
    UILocalNotification *note = [[UILocalNotification alloc] init];
    
    note.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];
    
    note.timeZone = [NSTimeZone defaultTimeZone];
    
    note.alertBody = @"这是通知内容";
    
    note.alertLaunchImage = @"Default";
    
    note.alertAction = @"这是锁屏界面信息";
    
    note.soundName = @"123.mp3";
    
    note.applicationIconBadgeNumber = 998;
    
    note.userInfo = @{
                    @"name":@"archy",
                    @"age":@"28",
                    @"phone":@"18800135435"
                    };
    UIApplication *app = [UIApplication sharedApplication];
    
    [app scheduleLocalNotification:note];
}


- (void)removeNote
{
    UIApplication *app = [UIApplication sharedApplication];
    
    [app cancelAllLocalNotifications];
}
@end
