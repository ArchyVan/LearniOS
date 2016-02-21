//
//  ViewController.m
//  HttpRequest
//
//  Created by Archy on 15/6/5.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD+MJ.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()<NSXMLParserDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)sendJSONdataOrMuchAttributes
{
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/MJServer/order"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    NSDictionary *orderInfo = @{
                                @"shop_id" : @"1243324",
                                @"shop_name" : @"啊哈哈哈",
                                @"user_id" : @"899"
                                };
    
    NSData *json = [NSJSONSerialization dataWithJSONObject:orderInfo options:NSJSONWritingPrettyPrinted error:nil];
    
    NSMutableString *param = [NSMutableString string];
    
    [param appendString:@"place=beijing"];
    [param appendString:@"&place=tianjin"];
    [param appendString:@"&place=shanghai"];
//    request.HTTPBody = [param dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = json;
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data == nil || connectionError) return;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSString *error = dict[@"error"];
        if (error) {
            [MBProgressHUD showError:error];
        } else {
            NSString *success = dict[@"success"];
            [MBProgressHUD showSuccess:success];
        }
        
    }];
}
- (void)connectBaidu
{
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", str);
        
    }];
    
}
- (void)postRequest
{
    NSString *urlStr = [NSString stringWithFormat:@"http://localhost:8080/MJServer/login"];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    /**
     *  设定超时时间
     */
    request.timeoutInterval = 15;
    
    request.HTTPMethod = @"POST";
    
    NSString *param = @"username=hehe&pwd=123";
    
    request.HTTPBody = [param dataUsingEncoding:NSUTF8StringEncoding];
    
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    
        if (connectionError || data == nil) {
            [MBProgressHUD showError:@"Request Failed"];
            return ;
        }
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSString *error = dict[@"error"];
        if (error) {
            [MBProgressHUD showError:error];
        } else {
            NSString *success = dict[@"success"];
            [MBProgressHUD showSuccess:success];
        }
        
    }];
    
}
- (void)nsxmlparserParsing
{
    NSString *urlStr = [NSString stringWithFormat:@"http://localhost:8080/MJServer/login"];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError || data == nil) {
            [MBProgressHUD showError:@"Request Failed"];
            return ;
        }
        
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        
//        NSString *error = dict[@"error"];
//        if (error) {
//            [MBProgressHUD showError:error];
//        } else {
//            NSString *success = dict[@"success"];
//            [MBProgressHUD showSuccess:success];
//        }
        
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
        
        parser.delegate =self;
        /**
         *  串式执行
         */
        [parser parse];
        
    }];
}

#pragma mark - NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([@"Tail Element" isEqualToString:elementName]) return;
    
    /**
     *  此处可以写KVC赋值
     *
     */
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSLog(@"%s",__func__);
}
-(void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"%s",__func__);
}
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"%s",__func__);
}


#pragma mark - 同步异步网络请求
- (void)synchronousRequest
{
    NSString *urlStr = [NSString stringWithFormat:@"http://localhost:8080/MJServer/login"];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSLog(@"---begin");
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSString *error = dict[@"error"];
    if (error) {
        [MBProgressHUD showError:error];
    } else {
        NSString *success = dict[@"success"];
        [MBProgressHUD showSuccess:success];
    }
    
    
    
}

- (void)asynchronousRequest
{
    NSString *urlStr = [NSString stringWithFormat:@"http://localhost:8080/MJServer/login"];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError || data == nil) {
            [MBProgressHUD showError:@"Request Failed"];
            return ;
        }
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSString *error = dict[@"error"];
        if (error) {
            [MBProgressHUD showError:error];
        } else {
            NSString *success = dict[@"success"];
            [MBProgressHUD showSuccess:success];
        }
        
    }];
}



- (void)videoPlay:(NSString *)urlStr
{
    MPMoviePlayerViewController *playerVc =[[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:urlStr]];
    
    [self presentViewController:playerVc animated:YES completion:nil];
}
@end
