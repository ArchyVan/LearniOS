//
//  ViewController.m
//  NetWorkObserver
//
//  Created by Archy on 15/6/6.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"
#import "Reachability.h"
#import "NetworkTool.h"

@interface ViewController ()

@property (nonatomic ,strong) Reachability *reachability;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)configReachability
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStateChange) name:kReachabilityChangedNotification object:nil];
    
    self.reachability = [Reachability reachabilityForInternetConnection];
    
    [self.reachability startNotifier];
}
- (void)dealloc
{
    [self.reachability stopNotifier];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)networkStateChange
{
    NSLog(@"网络状态改变了");
}
- (void)checkNetworkState
{
    if ([NetworkTool isEnableWIFI]) {
        NSLog(@"WIFI环境");
    } else if ([NetworkTool isEnable3G]){
        NSLog(@"手机自带网络");
    } else {
        NSLog(@"没有网络");
    }
}
@end
