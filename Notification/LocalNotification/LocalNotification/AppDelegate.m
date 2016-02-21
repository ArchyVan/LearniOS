//
//  AppDelegate.m
//  LocalNotification
//
//  Created by Archy on 15/6/19.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    if ([UIDevice currentDevice].systemVersion.doubleValue >= 8.0) {
        UIUserNotificationType type = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type categories:nil];
        
        [application registerUserNotificationSettings:settings];
    }
    
    static int count = 0;
    count++;
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 40, 200, 200);
    label.numberOfLines = 0;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:21];
    label.backgroundColor = [UIColor orangeColor];
    label.text = [NSString stringWithFormat:@" %@", launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]];
    [self.window.rootViewController.view addSubview:label];
    
    return YES;
}
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    static int count = 0;
    count++;
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 250, 200, 200);
    label.numberOfLines = 0;
    label.textColor = [UIColor whiteColor];
    label.text = [NSString stringWithFormat:@" %@", notification.userInfo];
    label.font = [UIFont systemFontOfSize:21];
    label.backgroundColor = [UIColor grayColor];
    [self.window.rootViewController.view addSubview:label];
}

@end
