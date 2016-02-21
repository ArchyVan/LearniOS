//
//  ViewController.m
//  pthread
//
//  Created by Archy on 15/6/2.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"
#import <pthread/pthread.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    pthread_t oneThread;
    
    pthread_create(&oneThread, NULL, run, NULL);
}

void *run(void *data)
{
    for (int i = 0; i < 10000; i++) {
        NSLog(@"---touches Began---%d---%@---",i,[NSThread currentThread]);
    }
    return NULL;
}
@end
