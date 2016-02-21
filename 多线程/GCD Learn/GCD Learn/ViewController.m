//
//  ViewController.m
//  GCD Learn
//
//  Created by Archy on 15/6/1.
//  Copyright (c) 2015年 Van. All rights reserved.
//


// dispatch_sync : 同步，不具备开启线程的能力
// dispatch_async : 异步，具备开启线程的能力

// 并发队列 ：多个任务可以同时执行
// 串行队列 ：一个任务执行完后，再执行下一个任务

// Foundation :  OC
// Core Foundation : C语言
// Foundation和Core Foundation框架的数据类型可以互相转换的

//NSString *str = @"123"; // Foundation
//CFStringRef str2 = (__bridge CFStringRef)str; // Core Foundation
//NSString *str3 = (__bridge NSString *)str2;
//    CFArrayRef ---- NSArray
//    CFDictionaryRef ---- NSDictionary
//    CFNumberRef ---- NSNumber

// Core Foundation中手动创建的数据类型，都需要手动释放
//    CFArrayRef array = CFArrayCreate(NULL, NULL, 10, NULL);
//    CFRelease(array);
//
//
//    CGPathRef path = CGPathCreateMutable();
//    CGPathRetain(path);
//
//    CGPathRelease(path);
//    CGPathRelease(path);
/**
 凡是函数名中带有create\copy\new\retain等字眼, 都应该在不需要使用这个数据的时候进行release
 GCD的数据类型在ARC环境下不需要再做release
 CF(Core Foundation)的数据类型在ARC\MRC环境下都需要再做release
 */

#define kGlobalQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define kMainQueue dispatch_get_main_queue()

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    

    
}

- (void)groupQueue
{
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    __block UIImage *image1 = nil;
    dispatch_group_async(group, queue, ^{
        NSURL *url1 = [NSURL URLWithString:@"http://g.hiphotos.baidu.com/image/pic/item/f2deb48f8c5494ee460de6182ff5e0fe99257e80.jpg"];
        NSData *data1 = [NSData dataWithContentsOfURL:url1];
        image1 = [UIImage imageWithData:data1];
    });
    
    
    __block UIImage *image2 = nil;
    dispatch_group_async(group, queue, ^{
        NSURL *url2 = [NSURL URLWithString:@"http://su.bdimg.com/static/superplus/img/logo_white_ee663702.png"];
        NSData *data2 = [NSData dataWithContentsOfURL:url2];
        image2 = [UIImage imageWithData:data2];
    });
    
    dispatch_group_notify(group, queue, ^{
        
        UIGraphicsBeginImageContextWithOptions(image1.size, NO, 0.0);
        
        CGFloat image1W = image1.size.width;
        CGFloat image1H = image1.size.height;
        [image1 drawInRect:CGRectMake(0, 0, image1W, image1H)];
        
        CGFloat image2W = image2.size.width * 0.5;
        CGFloat image2H = image2.size.height * 0.5;
        CGFloat image2X = image1W - image2W;
        CGFloat image2Y = image1H - image2H;
        [image2 drawInRect:CGRectMake(image2X, image2Y, image2W, image2H)];
        
        UIImage *fullImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSLog(@"%@",fullImage);
            
        });
        
    });
    
}
- (void)onceCode
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"---once---%@---",[NSThread currentThread]);
    });
}
- (void)threadDelay
{
    /**
     *  delay1
     *  一旦定制好延迟任务后，不会卡主当前线程
     */
    [self performSelector:@selector(download:) withObject:@"http://555.jpg" afterDelay:3];
    /**
     *  delay2
     *  延迟执行不要用sleep，坏处：卡住当前线程
     */
    [NSThread sleepForTimeInterval:3];
    /**
     *  delay3
     *
     */
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), mainQueue, ^{
        NSLog(@"---task---%@---",[NSThread currentThread]);
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), queue, ^{
        NSLog(@"---task---%@---",[NSThread currentThread]);
    });
}
- (void)threadCommunication
{
    /**
     *  GCD线程之间的通信
     */
    dispatch_async(kGlobalQueue, ^{
        NSLog(@"download--%@",[NSThread currentThread]);
        
        NSURL *url = [NSURL URLWithString:@"http://d.hiphotos.baidu.com/image/pic/item/37d3d539b6003af3290eaf5d362ac65c1038b652.jpg"];
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        UIImage *image = [UIImage imageWithData:data];
        
        dispatch_async(kMainQueue, ^{
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.image = image;
            
        });
        
    });
}
/**
 *  async -- 并发队列（最常用）
 *  会不会创建线程：会，一般同时开多条
 *  任务的执行方式：并发执行
 */
- (void)asyncGlobalQueue
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        NSLog(@"----下载图片1----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----下载图片2----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----下载图片3----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----下载图片4----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----下载图片5----%@",[NSThread currentThread]);
    });
}
/**
 *  async -- 串行队列（有时候用）
 *  会不会创建线程：会，一般只开1条线程
 *  任务的执行方式：串行执行（一个任务执行完毕后再执行下一个任务）
 */
- (void)asyncSerialQueue
{
    dispatch_queue_t queue = dispatch_queue_create("serialQueue", NULL);
    
    dispatch_async(queue, ^{
        NSLog(@"----下载图片1----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----下载图片2----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----下载图片3----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----下载图片4----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----下载图片5----%@",[NSThread currentThread]);
    });
    
}
/**
 *  async -- 主队列(很常用)
 */
- (void)asyncMainQueue
{
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
        NSLog(@"----下载图片1----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----下载图片2----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----下载图片3----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----下载图片4----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----下载图片5----%@",[NSThread currentThread]);
    });
    
}
/**-------------------------------------华丽的分割线-----------------------------------------------------**/
/**
 *  GCD同步
 */
/**
 *  sync -- 主队列(不能用---会卡死)
 */
- (void)syncManiQueue
{
    NSLog(@"syncMainQueue----begin--");
    
    // 1.主队列(添加到主队列中的任务，都会自动放到主线程中去执行)
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    // 2.添加 任务 到主队列中 异步 执行
    dispatch_sync(queue, ^{
        NSLog(@"-----下载图片1---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"-----下载图片2---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"-----下载图片3---%@", [NSThread currentThread]);
    });
    /**
     *  限制性这句，但按照编译逻辑又最后执行，所以矛盾
     */
    NSLog(@"syncMainQueue----end--");
}
/**
 *  sync -- 并发队列
 *  会不会创建线程：不会
 *  任务的执行方式：串行执行（一个任务执行完毕后再执行下一个任务）
 *  并发队列失去了并发的功能
 */
- (void)syncGlobalQueue
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_sync(queue, ^{
        NSLog(@"----下载图片1----%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"----下载图片2----%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"----下载图片3----%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"----下载图片4----%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"----下载图片5----%@",[NSThread currentThread]);
    });
}
/**
 *  sync -- 串行队列
 *  会不会创建线程：不会
 *  任务的执行方式：串行执行（一个任务执行完毕后再执行下一个任务）
 */
- (void)syncSerialQueue
{
    dispatch_queue_t queue = dispatch_queue_create("serialQueue", NULL);
    
    dispatch_sync(queue, ^{
        NSLog(@"----下载图片1----%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"----下载图片2----%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"----下载图片3----%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"----下载图片4----%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"----下载图片5----%@",[NSThread currentThread]);
    });
}
@end
