//
//  ViewController.m
//  FileUpload
//
//  Created by Archy on 15/6/7.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"
#define VAFileBoundary @"MyServer"
#define VANewLine @"\r\n"
#define VAEncode(str) [str dataUsingEncoding:NSUTF8StringEncoding]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (void)upload
{
    NSDictionary *params = @{
                             @"username" : @"李四",
                             @"pwd" : @"123",
                             @"age" : @30,
                             @"height" : @"1.55"
                             };
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"autolayout" withExtension:@"txt"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSString *MIMEType = [self MIMEType:url];
    [self upload:@"test.txt" mimeType:MIMEType fileData:data params:params];
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
- (void)upload:(NSString *)fileName mimeType:(NSString *)mimeType fileData:(NSData *)fileData params:(NSDictionary *)params
{
    NSURL *url = [NSURL URLWithString:@"http://192.168.15.172:8080/MJServer/upload"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"POST";
    
    NSMutableData *body = [NSMutableData data];
    
    [body appendData:VAEncode(@"--")];
    [body appendData:VAEncode(VAFileBoundary)];
    [body appendData:VAEncode(VANewLine)];

    NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\";filename=\"%@\"",fileName];
    [body appendData:VAEncode(disposition)];
    [body appendData:VAEncode(VANewLine)];
    
    NSString *type = [NSString stringWithFormat:@"Content-Type: %@",mimeType];
    
    [body appendData:VAEncode(type)];
    [body appendData:VAEncode(VANewLine)];
    
    [body appendData:VAEncode(VANewLine)];
    [body appendData:fileData];
    [body appendData:VAEncode(VANewLine)];
    
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        [body appendData:VAEncode(@"--")];
        [body appendData:VAEncode(VAFileBoundary)];
        [body appendData:VAEncode(VANewLine)];
        
        NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"",key];
        
        [body appendData:VAEncode(disposition)];
        [body appendData:VAEncode(VANewLine)];
        
        [body appendData:VAEncode(VANewLine)];
        [body appendData:VAEncode([obj description])];
        [body appendData:VAEncode(VANewLine)];
        
    }];
    [body appendData:VAEncode(@"--")];
    [body appendData:VAEncode(VAFileBoundary)];
    [body appendData:VAEncode(@"--")];
    [body appendData:VAEncode(VANewLine)];
    
    request.HTTPBody = body;
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",VAFileBoundary];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"%@",dict);
        
    }];
}







@end











