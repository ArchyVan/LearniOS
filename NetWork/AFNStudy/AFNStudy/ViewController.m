//
//  ViewController.m
//  AFNStudy
//
//  Created by Archy on 15/6/8.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)AFNReachability
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WIFI");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"自带网络");
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                break;
                
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                break;
            default:
                break;
        }
    }];
    
    [manager startMonitoring];
}
- (void)dealloc
{
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}
- (void)postUpload
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"username"] = @"123";
    params[@"pwd"] = @"123";
    
    NSString *url = @"http://localhost:8080/MJServer/upload";
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        UIImage *image = [UIImage imageNamed:@"31"];
        
        NSData *fileData = UIImageJPEGRepresentation(image, 1.0);
        
        [formData appendPartWithFileData:fileData name:@"file" fileName:@"new.jpg" mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Request Successed---%@",responseObject);

        
    } failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Request Failed---%@",error.localizedDescription);

     }];
}
- (void)postJSON
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"username"] = @"123";
    params[@"pwd"] = @"123";
    
    NSString *url = @"http://localhost:8080/MJServer/login";
    
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        NSLog(@"Request Successed---%@",responseObject);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Request Failed---%@",error.localizedDescription);

    }];
}
- (void)getSession
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"username"] = @"123";
    params[@"pwd"] = @"123";
    NSString *url = @"http://localhost:8080/MJServer/login";
    
    [manager GET:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"Request Successed---%@",responseObject);

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Request Failed---%@",error.localizedDescription);

    }];
    
}
- (void)getData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"username"] = @"123";
    params[@"pwd"] = @"123";
    NSString *url = @"http://localhost:8080/MJServer/login";
    
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Request Successed---%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Request Failed---%@",error.localizedDescription);
        
    }];
}

- (void)getXML
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"username"] = @"123";
    params[@"pwd"] = @"123";
    params[@"type"] = @"XML";
    NSString *url = @"http://localhost:8080/MJServer/login";

    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Request Successed---%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Request Failed---%@",error.localizedDescription);
        
    }];
}

- (void)getJSON
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"username"] = @"123";
    params[@"pwd"] = @"123";
    
    NSString *url = @"http://localhost:8080/MJServer/login";
    
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Request Successed---%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Request Failed---%@",error.localizedDescription);
        
    }];
}
@end
