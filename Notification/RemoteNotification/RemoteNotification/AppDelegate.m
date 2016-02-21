//
//  AppDelegate.m
//  RemoteNotification
//
//  Created by Archy on 15/6/19.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    if ([[UIDevice currentDevice].systemVersion doubleValue] <= 8.0) {
        UIRemoteNotificationType type = UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound;
        
        [application registerForRemoteNotificationTypes:type];
    } else {
        
        UIUserNotificationType  type = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type categories:nil];
        
        [application registerUserNotificationSettings:settings];
        
        [application registerForRemoteNotifications];
        
    }
    
    
    NSDictionary *userInfo = launchOptions[UIApplicationLaunchOptionsLocalNotificationKey];
    
    if (userInfo) {
        static int count = 0;
        count++;
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 40, 200, 200);
        label.numberOfLines = 0;
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor orangeColor];
        label.font = [UIFont systemFontOfSize:11];
        label.text = [NSString stringWithFormat:@" %@ \n %d",userInfo,count];
        [self.window.rootViewController.view addSubview:label];
    }
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"%@",deviceToken);
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    /*
     如果应用程序在后台 , 只有用户点击了通知之后才会调用
     如果应用程序在前台, 会直接调用该方法
     即便应用程序关闭也可以接收到远程通知
     */
    NSLog(@"%@",userInfo);
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    /*
     UIBackgroundFetchResultNewData, 成功接收到数据
     UIBackgroundFetchResultNoData, 没有;接收到数据
     UIBackgroundFetchResultFailed 接收失败
     */
    NSLog(@"%@",userInfo);
    
    NSNumber *contentid = userInfo[@"content-id"];
    if (contentid) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 250, 200, 200);
        label.numberOfLines = 0;
        label.textColor = [UIColor whiteColor];
        label.text = [NSString stringWithFormat:@"%@", contentid];
        label.font = [UIFont systemFontOfSize:30];
        label.backgroundColor = [UIColor grayColor];
        [self.window.rootViewController.view addSubview:label];
        //注意: 在此方法中一定要调用这个调用block, 告诉系统是否处理成功.
        // 以便于系统在后台更新UI等操作
        completionHandler(UIBackgroundFetchResultNewData);
    } else {
        completionHandler(UIBackgroundFetchResultFailed);
    }

}
@end
