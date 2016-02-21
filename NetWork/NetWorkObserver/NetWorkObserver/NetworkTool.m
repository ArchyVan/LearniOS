//
//  NetworkTool.m
//  NetWorkObserver
//
//  Created by Archy on 15/6/6.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "NetworkTool.h"
#import "Reachability.h"
@implementation NetworkTool

+ (BOOL)isEnableWIFI
{
    return ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable);
}

+ (BOOL)isEnable3G
{
    return ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus] != NotReachable);
}
@end
