//
//  CustomDownloadOperation.m
//  Cell_ImageView_Download
//
//  Created by Archy on 15/6/4.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "CustomDownloadOperation.h"

@implementation CustomDownloadOperation
- (void)main
{
    @autoreleasepool {
        
        if (self.isCancelled) return;
        
        NSURL *url = [NSURL URLWithString:self.imageUrl];
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        UIImage *image =[UIImage imageWithData:data];
        
        if (self.isCancelled) return;
        
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            
            if ([self.delegate respondsToSelector:@selector(downloadOperation:didFinishedDownload:)]) {
                [self.delegate downloadOperation:self didFinishedDownload:image];
            }
            
        }];
        
    }
}

@end
