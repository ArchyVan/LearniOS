//
//  DownloadViewController.m
//  ASILearn
//
//  Created by Archy on 15/6/8.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "DownloadViewController.h"
#import "ASIFormDataRequest.h"
@interface DownloadViewController ()

@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, assign) BOOL downloading;
@property (nonatomic, strong) ASIHTTPRequest *request;

@end

@implementation DownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)upload
{
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/MJServer/upload"];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request setPostValue:@"zhangSan" forKey:@"username"];
    [request setPostValue:@"123" forKey:@"pwd"];
    [request setPostValue:@"28" forKey:@"age"];
    [request setPostValue:@"1.89" forKey:@"height"];
    
    NSString *file = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"mp4"];
    
    [request setFile:file forKey:@"file"];

    request.uploadProgressDelegate = self.progressView;
    [request startAsynchronous];
    
    __weak typeof(request) weakRequest = request;
    
    [request setCompletionBlock:^{
        NSLog(@"%@",[weakRequest responseString]);
    }];
}
- (void)download
{
    if (self.downloading) {
        [self.request clearDelegatesAndCancel];
        self.downloading = NO;
    } else {
        NSURL *url = [NSURL URLWithString:@"http://localhost:8080/MJServer/resources/test.mp4"];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        
        NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        
        NSString *filePath = [caches stringByAppendingPathComponent:@"test.mp4"];
        
        request.downloadDestinationPath = filePath;
        
        request.downloadProgressDelegate = self.progressView;
        
        request.allowResumeForFileDownloads = YES;
        
        request.temporaryFileDownloadPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"test.temp"];
        
        [request startAsynchronous];
        
        self.request = request;
        
        self.downloading = YES;
        
    }
}


@end
