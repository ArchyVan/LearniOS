//
//  ViewController.m
//  NSOperation
//
//  Created by Archy on 15/6/2.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)operationCommunication
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [queue addOperationWithBlock:^{
        
        NSURL *url = [NSURL URLWithString:@"http://d.hiphotos.baidu.com/image/pic/item/37d3d539b6003af3290eaf5d362ac65c1038b652.jpg"];
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        UIImage *image = [UIImage imageWithData:data];
        
        // 回到主线程，显示图片
        //        [self performSelectorOnMainThread:<#(SEL)#> withObject:<#(id)#> waitUntilDone:<#(BOOL)#>];
        //        dispatch_async(dispatch_get_main_queue(), ^{
        //
        //        });
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            NSLog(@"---%@---",image);
            
        }];
        
    }];
}
- (void)dependency
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    /**
     假设有A、B、C三个操作，要求：
     1. 3个操作都异步执行
     2. 操作C依赖于操作B
     3. 操作B依赖于操作A
     */
    NSBlockOperation *operationA = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"---A---%@---",[NSThread currentThread]);
    }];
    
    NSBlockOperation *operationB = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"---B---%@---",[NSThread currentThread]);
    }];
    
    NSBlockOperation *operationC = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"---C---%@---",[NSThread currentThread]);
    }];
    
    [operationB addDependency:operationA];
    [operationC addDependency:operationB];
    
    [queue addOperation:operationB];
    [queue addOperation:operationC];
    [queue addOperation:operationA];
}
- (void)maxCount
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 2.设置最大并发(最多同时并发执行3个任务)
    queue.maxConcurrentOperationCount = 3;
    
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下载图片1---%@", [NSThread currentThread]);
    }];
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下载图片2---%@", [NSThread currentThread]);
    }];
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下载图片3---%@", [NSThread currentThread]);
    }];
    NSBlockOperation *operation4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下载图片4---%@", [NSThread currentThread]);
    }];
    NSInvocationOperation *operation5 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(download) object:nil];
    
    [queue addOperation:operation1];
    [queue addOperation:operation2];
    [queue addOperation:operation3];
    [queue addOperation:operation4];
    [queue addOperation:operation5];
    
    [queue addOperationWithBlock:^{
        NSLog(@"下载图片5---%@", [NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"下载图片6---%@", [NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"下载图片7---%@", [NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"下载图片8---%@", [NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"下载图片9---%@", [NSThread currentThread]);
    }];
    //取消所有操作不能恢复
    [queue cancelAllOperations];
    
//    [queue setSuspended:YES]; // 暂停队列中的所有任务

//    [queue setSuspended:NO]; // 恢复队列中的所有任务

}

- (void)nsblockOperation
{
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"---download1---%@",[NSThread currentThread]);
    }];
    
    [operation1 addExecutionBlock:^{
        NSLog(@"---download11---%@",[NSThread currentThread]);
    }];
    
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"---download2---%@",[NSThread currentThread]);
    }];
    
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"---download3---%@",[NSThread currentThread]);
    }];
    
    NSBlockOperation *operation4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"---download4---%@",[NSThread currentThread]);
    }];
    
    [queue addOperation:operation1];
    [queue addOperation:operation2];
    [queue addOperation:operation3];
    [queue addOperation:operation4];
    
    // 任务数量 > 1，才会开始异步执行
    //    [operation1 start];
}
- (void)nsinvocationOperation
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(download) object:nil];
    
    [queue addOperation:operation];
}
- (void)download
{
    NSLog(@"download-----%@", [NSThread currentThread]);
}
@end
