//
//  ViewController.m
//  practiceChat
//
//  Created by Archy on 15/6/18.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSStreamDelegate>
{
    NSInputStream *_inputStream;
    NSOutputStream *_outputStream;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)connectToHost
{
    NSString *host = @"127.0.0.1";
    int port = 12345;
    
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToCFHost(NULL, (__bridge CFHostRef)(host), port, &readStream, &writeStream);
    
    _inputStream = (__bridge NSInputStream *)(readStream);
    _outputStream = (__bridge NSOutputStream *)(writeStream);
    
    _inputStream.delegate = self;
    _outputStream.delegate = self;
    
    [_inputStream scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [_outputStream scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    [_inputStream open];
    [_outputStream open];
    
}
- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
{
    NSLog(@"%@",aStream);
    
    switch (eventCode) {
        case NSStreamEventOpenCompleted:
            NSLog(@"输入输出流打开完成");
            break;
        case NSStreamEventHasBytesAvailable:
            NSLog(@"有字节可读");
            break;
        case NSStreamEventHasSpaceAvailable:
            NSLog(@"可以发送字节");
            break;
        case NSStreamEventErrorOccurred:
            NSLog(@" 连接出现错误");
            break;
        case NSStreamEventEndEncountered:
            NSLog(@"连接结束");
            
            // 关闭输入输出流
            [_inputStream close];
            [_outputStream close];
            
            // 从主运行循环移除
            [_inputStream removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
            [_outputStream removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
            break;
        default:
            break;
    }
}

- (void)login
{
    NSString *loginStr = @"iam:archy";
    
    NSData *data = [loginStr dataUsingEncoding:NSUTF8StringEncoding];
    
    [_outputStream write:data.bytes maxLength:data.length];
}
- (void)readData
{
    uint8_t buf[1024];
    
    NSInteger len = [_inputStream read:buf maxLength:sizeof(buf)];
    
    NSData *data = [NSData dataWithBytes:buf length:len];
    
    NSString *recStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",recStr);
}
- (void)writeData
{
    NSString *msgStr = [NSString stringWithFormat:@"msg:%@",@"内容"];
    
    NSData *data = [msgStr dataUsingEncoding:NSUTF8StringEncoding];
    
    [_outputStream write:data.bytes maxLength:data.length];
    
}
@end
