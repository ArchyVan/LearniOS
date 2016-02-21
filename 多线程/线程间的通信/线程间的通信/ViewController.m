//
//  ViewController.m
//  线程间的通信
//
//  Created by Archy on 15/6/1.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    //first method
//    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(download) object:nil];
//    
//    [thread start];
    
    
//    //second method
//    [NSThread detachNewThreadSelector:@selector(download) toTarget:self withObject:nil];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self performSelectorInBackground:@selector(download) withObject:nil];
}
- (void)download
{
    NSLog(@"download---%@",[NSThread currentThread]);
    
    NSString *urlStr = @"http://d.hiphotos.baidu.com/image/pic/item/37d3d539b6003af3290eaf5d362ac65c1038b652.jpg";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSLog(@"---begin");
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSLog(@"---end");
    
    UIImage *imaga = [UIImage imageWithData:data];
    
    [self performSelectorOnMainThread:@selector(downloadFinished:) withObject:imaga waitUntilDone:NO];
    
    NSLog(@"---done---");
}
- (void)downloadFinished:(UIImage *)image
{
    self.imgView.image = image;
    
    NSLog(@"downloadFinished---%@",[NSThread currentThread]);
}
@end
