//
//  SessionDownloadViewController.m
//  NSURLSession
//
//  Created by Archy on 15/6/7.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "SessionDownloadViewController.h"

@interface SessionDownloadViewController ()<NSURLSessionDownloadDelegate,NSURLSessionDataDelegate>

@property (nonatomic, strong) NSURLSessionDownloadTask *task;
@property (nonatomic, strong) NSData *resumeData;
@property (nonatomic, strong) NSURLSession *session;

@end

@implementation SessionDownloadViewController
/**
 *  NSURLSession断点续传(下载)的视图控制器
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    
    button.frame = CGRectMake(10, 0, 355, 30);
    button.center = self.view.center;
    
    [button setTitle:@"Pause" forState:UIControlStateNormal];
    [button setTitle:@"Start" forState:UIControlStateSelected];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}
- (NSURLSession *)session
{
    if (!_session) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;
}
- (void)buttonClicked:(UIButton *)button
{
    button.selected = !button.isSelected;
    
    if (self.task == nil) {
        if (self.resumeData) {
            [self resume];
        } else {
            [self start];
        }
    } else {
        [self pause];
    }
}
- (void)start
{
    NSURL *url = [NSURL URLWithString:@"http://192.168.15.172:8080/MJServer/resources/videos/minion_01.mp4"];
    
    self.task = [self.session downloadTaskWithURL:url];
    
    [self.task resume];
}
- (void)resume
{
    self.task = [self.session downloadTaskWithResumeData:self.resumeData];
    
    [self.task resume];
    
    self.resumeData = nil;
}
- (void)pause
{
    __weak typeof(self) mySelf = self;
    [self.task cancelByProducingResumeData:^(NSData *resumeData) {
        mySelf.resumeData = resumeData;
        NSLog(@"%ld",resumeData.length);
        mySelf.task = nil;
    }];
}
#pragma mark - NSURLSessionDownloadDelegate
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *file = [caches stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    [manager moveItemAtPath:location.path toPath:file error:nil];

}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    double progress = (double)totalBytesWritten / totalBytesExpectedToWrite;
    
    NSLog(@"Have downloaded %f",progress);
    NSLog(@"---%@---",[NSThread currentThread]);
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
    NSLog(@"%s",__func__);
}
@end
