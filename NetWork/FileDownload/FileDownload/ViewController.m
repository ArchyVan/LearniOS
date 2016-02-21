//
//  ViewController.m
//  FileDownload
//
//  Created by Archy on 15/6/6.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"

#import "DACircularProgressView.h"

@interface ViewController ()<NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSFileHandle *writeHandle;

@property (nonatomic, assign) long long totalLength;

@property (nonatomic, assign) long long currentLength;

@property (nonatomic, strong) NSURLConnection *connection;

@property (nonatomic, weak) DACircularProgressView *circleView;


- (IBAction)btnClicked:(UIButton *)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    DACircularProgressView *circleView = [[DACircularProgressView alloc] initWithFrame:CGRectMake(100, 50, 100, 100)];
    
    CGPoint center = circleView.center;
    
    center.x = self.view.center.x;
    
    circleView.center = center;
    
    circleView.progressTintColor = [UIColor orangeColor];
    
    circleView.trackTintColor = [UIColor lightGrayColor];
    
    circleView.progress = 0.000001;
    [self.view addSubview:circleView];
    self.circleView = circleView;
}

/**
 *  大文件的下载
 */
#pragma mark - NSURLConnectionDataDelegate
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",error.localizedDescription);
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self.currentLength = 0;
    self.totalLength = 0;
    
    [self.writeHandle closeFile];
    self.writeHandle = nil;
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if (self.currentLength) return;
    
    NSString *cacherPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [cacherPath stringByAppendingPathComponent:@"videos.zip"];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    [manager createFileAtPath:filePath contents:nil attributes:nil];
    
    self.writeHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
    //    NSHTTPURLResponse *resp = (NSHTTPURLResponse *)response;
    //    long long fileLength = [resp.allHeaderFields[@"Content-Length"] longLongValue];
    self.totalLength = response.expectedContentLength;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.writeHandle seekToEndOfFile];
    
    [self.writeHandle writeData:data];
    
    self.currentLength += data.length;
    
    self.circleView.progress = (double)self.currentLength / self.totalLength;
}
- (IBAction)btnClicked:(UIButton *)sender {
    
    sender.selected = !sender.isSelected;
    
    if (sender.selected) {
        NSURL *url = [NSURL URLWithString:@"http://localhost:8080/MJServer/resources/videos.zip"];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        NSString *range = [NSString stringWithFormat:@"bytes=%lld-",self.currentLength];
        [request setValue:range forHTTPHeaderField:@"Range"];
        
        self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    } else {
        [self.connection cancel];
        self.connection = nil;
    }
    
}
/**
 *  小文件的下载
 */
- (void)downloadFileSmall1
{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSURL *url = [NSURL URLWithString:@"http://localhost:8080/MJServer/resources/images/minion_01.png"];
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        NSLog(@"%ld",data.length);
        
    });
    
}

- (void)downloadFileSmall2
{
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/MJServer/resources/images/minion_01.png"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSLog(@"%ld",data.length);
    }];
}


@end
