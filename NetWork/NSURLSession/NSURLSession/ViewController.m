//
//  ViewController.m
//  NSURLSession
//
//  Created by Archy on 15/6/7.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLSessionDownloadDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
// NSURLSessionDataTask : 普通的GET\POST请求
// NSURLSessionDownloadTask : 文件下载
// NSURLSessionUploadTask : 文件上传
#pragma mark - NSURLSessionDataTask
- (void)dataTask
{
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURL *url = [NSURL URLWithString:@"http://192.168.15.172:8080/MJServer/login"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"POST";
    
    request.HTTPBody = [@"username=123&pwd=123" dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        NSLog(@"---%@",dict);
        
    }];
    
    [task resume];
}
#pragma mark - NSURLSessionDownloadTask
- (void)downloadTask
{
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/MJServer/resources/test.mp4"];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        
        NSString *file = [caches stringByAppendingPathComponent:response.suggestedFilename];
        
        NSFileManager *manager = [NSFileManager defaultManager];
        
        [manager moveItemAtPath:location.path toPath:file error:nil];
        
    }];
    [task resume];
}
#pragma mark - NSURLSessionDownloadTask_BIGFILE
- (void)downloadTaskForBigFile
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/MJServer/resources/test.mp4"];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url];
    
    [task resume];
}
 #pragma mark - NSURLSessionDataDelegate
/**
 *  下载完毕后调用
 *
 *  @param location     临时文件的路径（下载好的文件）
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *file = [caches stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    [manager moveItemAtPath:location.path toPath:file error:nil];
    
}
/**
 *  恢复下载时调用
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
    NSLog(@"%s",__func__);
}
/**
 *  每当下载完（写完）一部分时就会调用（可能会被调用多次）
 *
 *  @param bytesWritten              这次调用写了多少
 *  @param totalBytesWritten         累计写了多少长度到沙盒中了
 *  @param totalBytesExpectedToWrite 文件的总长度
 */

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    double progress = (double)totalBytesWritten / totalBytesExpectedToWrite;
    
    NSLog(@"Have downloaded %f",progress);
    
}

@end
