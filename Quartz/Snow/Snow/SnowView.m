//
//  SnowView.m
//  Snow
//
//  Created by Archy on 15/6/14.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "SnowView.h"

@interface SnowView ()

@property (nonatomic, assign) CGFloat imageY;

@end

@implementation SnowView

- (void)awakeFromNib
{
//    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(setNeedsDisplay) userInfo:nil repeats:YES];

    // iphone每秒刷新60次
    // 屏幕刷新的时候就会触发
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(setNeedsDisplay)];
    
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    _imageY += 5;
    
    UIImage *image = [UIImage imageNamed:@"snow"];
    [image drawAtPoint:CGPointMake(0, _imageY)];
    
    if (_imageY >= 480) {
        _imageY = 0;
    }
    
}

@end
