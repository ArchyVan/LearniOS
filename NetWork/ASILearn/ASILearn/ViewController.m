//
//  ViewController.m
//  ASILearn
//
//  Created by Archy on 15/6/8.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface ViewController ()<ASIHTTPRequestDelegate>

@property (nonatomic, strong) ASIHTTPRequest *request;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)postRequest
{
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/MJServer/login"];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request setPostValue:@"123" forKey:@"username"];
    [request setPostValue:@"123" forKey:@"pwd"];
    
    [request startAsynchronous];
    __weak typeof(request) weakRequest = request;
    [request setCompletionBlock:^{
        
        NSLog(@"Request completed!---%@",[weakRequest responseString]);
        
    }];
}
/**
 监听ASI的请求
 1.成为代理，遵守ASIHTTPRequestDelegate协议，实现协议中的代理方法
 request.delegate = self;
 - (void)requestStarted:(ASIHTTPRequest *)request;
 - (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders;
 - (void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)data;
 - (void)requestFinished:(ASIHTTPRequest *)request;
 - (void)requestFailed:(ASIHTTPRequest *)request;
 
 2.成为代理，不遵守ASIHTTPRequestDelegate协议，自定义代理方法
 request.delegate = self;
 [request setDidStartSelector:@selector(start:)];
 [request setDidFinishSelector:@selector(finish:)];
 
 3.设置block
 [request setStartedBlock:^{
 NSLog(@"setStartedBlock");
 }];
 [request setHeadersReceivedBlock:^(NSDictionary *responseHeaders) {
 NSLog(@"setHeadersReceivedBlock--%@", responseHeaders);
 }];
 [request setDataReceivedBlock:^(NSData *data) {
 NSLog(@"setDataReceivedBlock--%@", data);
 }];
 [request setCompletionBlock:^{
 NSLog(@"setCompletionBlock");
 }];
 [request setFailedBlock:^{
 NSLog(@"setFailedBlock");
 }];
 */

- (void)asynGet
{
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/MJServer/video"];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    request.timeOutSeconds = 15;
    
    request.delegate = self;
    
    [request startAsynchronous];
    
    self.request = request;
}
- (void)dealloc
{
    [self.request clearDelegatesAndCancel];
}
-(void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)data
{
    NSLog(@"ReceiveData--%@",data);
}
-(void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders
{
    NSLog(@"%s",__func__);
}
-(void)requestStarted:(ASIHTTPRequest *)request
{
    NSLog(@"%s",__func__);
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"RequestFinished--%@",[request responseData]);
}
- (void)synGet
{
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/MJServer/video"];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    request.timeOutSeconds = 15;
    
    [request startSynchronous];
    
    NSError *error = [request error];
    
    if (error) {
        NSLog(@"Request Failed---%@",error);
    } else {
        NSData *data = [request responseData];
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        NSLog(@"Request Successed---%@",dict);
    }
}
@end
