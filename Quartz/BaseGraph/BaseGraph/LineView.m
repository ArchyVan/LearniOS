//
//  LineView.m
//  BaseGraph
//
//  Created by Archy on 15/6/13.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "LineView.h"

@implementation LineView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint startP = CGPointMake(10, 125);
    CGPoint endP = CGPointMake(240, 125);
    CGPoint controlP = CGPointMake(125, 0);
    
    [path moveToPoint:startP];
    [path addQuadCurveToPoint:endP controlPoint:controlP];
    
    CGContextAddPath(context, path.CGPath);
    
    CGContextStrokePath(context);
}

- (void)draw2Line
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(10, 125)];
    
    [path addLineToPoint:CGPointMake(230, 125)];
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    
    [path2 moveToPoint:CGPointMake(10, 10)];
    
    [path2 addLineToPoint:CGPointMake(125, 100)];
    
    CGContextAddPath(context, path.CGPath);
    CGContextAddPath(context, path2.CGPath);
    
    
    CGContextSetLineWidth(context, 10);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    [[UIColor redColor]set];
    
    CGContextStrokePath(context);
}

- (void)drawLine
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(10, 10)];
    
    [path addLineToPoint:CGPointMake(125, 125)];
    [path addLineToPoint:CGPointMake(240, 10)];
    
    CGContextAddPath(context, path.CGPath);
    
    CGContextStrokePath(context);
}

@end
