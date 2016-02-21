//
//  TestView.m
//  GraphicsContextPen
//
//  Created by Archy on 15/6/14.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "TestView.h"

@implementation TestView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

/**
 *  通过图形上下文栈保存绘画状态
 *
 */
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(10, 125)];
    [path addLineToPoint:CGPointMake(240, 125)];
    
    CGContextAddPath(context, path.CGPath);
    
    [[UIColor redColor] set];
    CGContextSetLineWidth(context, 10);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    CGContextStrokePath(context);
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(125, 10)];
    [path2 addLineToPoint:CGPointMake(125, 240)];
    CGContextAddPath(context, path2.CGPath);
    
    CGContextRestoreGState(context);
    
    CGContextStrokePath(context);
    
}
/**
 *  矩阵操作
 */
- (void)drawTransform
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 50, 100);
    
    CGContextRotateCTM(context, M_1_PI);
    
    CGContextScaleCTM(context, 0.5, 1.2);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-50, -100, 150, 200)];
    
    CGContextAddPath(context, path.CGPath);
    
    [[UIColor yellowColor] set];
    
    CGContextStrokePath(context);
}


@end










