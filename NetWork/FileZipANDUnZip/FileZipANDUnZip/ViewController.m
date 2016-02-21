//
//  ViewController.m
//  FileZipANDUnZip
//
//  Created by Archy on 15/6/8.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"
#import "SSZipArchive.h"

#define HMFileBoundary @"heima"
#define HMNewLien @"\r\n"
#define HMEncode(str) [str dataUsingEncoding:NSUTF8StringEncoding]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)unZip
{
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/MJServer/resources/images.zip"];
    
    NSURLSessionDownloadTask *task = [[NSURLSession sharedSession] downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        
        [SSZipArchive unzipFileAtPath:location.path toDestination:caches];
        
    }];
    
    [task resume];
}
- (void)createZip
{
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *files = [caches stringByAppendingPathComponent:@"images"];
    
    NSString *zipFile = [caches stringByAppendingPathComponent:@"images.zip"];
    
    BOOL result = [SSZipArchive createZipFileAtPath:zipFile withContentsOfDirectory:files];
    
    if (result) {
        NSString *MIMEType = [self MIMEType:[NSURL fileURLWithPath:zipFile]];
        
        NSData *data = [NSData dataWithContentsOfFile:zipFile];
        
        [self upload:@"images.zip" mimeType:MIMEType fileData:data params:@{@"username":@"archy"}];
    }
}
- (NSString *)MIMEType:(NSURL *)url
{
    // 1.创建一个请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 2.发送请求（返回响应）
    NSURLResponse *response = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    // 3.获得MIMEType
    return response.MIMEType;
}
- (void)upload:(NSString *)filename mimeType:(NSString *)mimeType fileData:(NSData *)fileData params:(NSDictionary *)params
{
    // 1.请求路径
    NSURL *url = [NSURL URLWithString:@"http://192.168.15.172:8080/MJServer/upload"];
    
    // 2.创建一个POST请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    // 3.设置请求体
    NSMutableData *body = [NSMutableData data];
    
    // 3.1.文件参数
    [body appendData:HMEncode(@"--")];
    [body appendData:HMEncode(HMFileBoundary)];
    [body appendData:HMEncode(HMNewLien)];
    
    NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@\"", filename];
    [body appendData:HMEncode(disposition)];
    [body appendData:HMEncode(HMNewLien)];
    
    NSString *type = [NSString stringWithFormat:@"Content-Type: %@", mimeType];
    [body appendData:HMEncode(type)];
    [body appendData:HMEncode(HMNewLien)];
    
    [body appendData:HMEncode(HMNewLien)];
    [body appendData:fileData];
    [body appendData:HMEncode(HMNewLien)];
    
    // 3.2.非文件参数
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [body appendData:HMEncode(@"--")];
        [body appendData:HMEncode(HMFileBoundary)];
        [body appendData:HMEncode(HMNewLien)];
        
        NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"", key];
        [body appendData:HMEncode(disposition)];
        [body appendData:HMEncode(HMNewLien)];
        
        [body appendData:HMEncode(HMNewLien)];
        [body appendData:HMEncode([obj description])];
        [body appendData:HMEncode(HMNewLien)];
    }];
    
    // 3.3.结束标记
    [body appendData:HMEncode(@"--")];
    [body appendData:HMEncode(HMFileBoundary)];
    [body appendData:HMEncode(@"--")];
    [body appendData:HMEncode(HMNewLien)];
    
    request.HTTPBody = body;
    
    // 4.设置请求头(告诉服务器这次传给你的是文件数据，告诉服务器现在发送的是一个文件上传请求)
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", HMFileBoundary];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    // 5.发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@", dict);
    }];
}

@end
