//
//  ShapeView.m
//  BaseGraph
//
//  Created by Archy on 15/6/14.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ShapeView.h"

@interface ShapeView ()

@property (nonatomic, weak) UILabel *label;

@end

@implementation ShapeView

- (UILabel *)label
{
    if (_label == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 100)];
        label.text = @"s";
        label.font = [UIFont systemFontOfSize:60];
        label.textColor = [UIColor yellowColor];
        label.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:label];
        _label = label;
    }
    return _label;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGPoint center = CGPointMake(125, 125);
    CGFloat radius = 100;
    CGFloat startA = 0;
    CGFloat endA = M_PI_2;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    [path addLineToPoint:center];
    UIBezierPath *shapePath = [UIBezierPath bezierPath];
    [shapePath moveToPoint:CGPointMake(0, 0)];
    [shapePath addLineToPoint:CGPointMake(0, 150)];
    [shapePath addLineToPoint:CGPointMake(375, 150)];
    [shapePath addLineToPoint:CGPointMake(375, 0)];
    [shapePath addQuadCurveToPoint:CGPointMake(0, 30) controlPoint:CGPointMake(375/2.0, 60)];
    [shapePath closePath];

    [[UIColor clearColor] set];
    CGContextAddPath(context, shapePath.CGPath);
    
//    CGContextClosePath(context);
//    CGContextStrokePath(context);
    CGContextFillPath(context);
    
}

- (void)drawArc
{
    CGContextRef context = UIGraphicsGetCurrentContext() ;
    
    CGPoint center = CGPointMake(125, 125);
    CGFloat radius = 100;
    CGFloat startA = 0;
    CGFloat endA = M_PI_2;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    
    UIBezierPath *shapePath = [UIBezierPath bezierPath];
    [shapePath moveToPoint:CGPointMake(0, 0)];
    [shapePath addLineToPoint:CGPointMake(0, 150)];
    [shapePath addLineToPoint:CGPointMake(375, 150)];
    [shapePath addLineToPoint:CGPointMake(375, 0)];
    [shapePath addQuadCurveToPoint:CGPointMake(0, 0) controlPoint:CGPointMake(375/2.0, 70)];
    [shapePath closePath];

    CGContextAddPath(context, shapePath.CGPath);
    
    // 4.渲染上下文
    CGContextStrokePath(context);
}

- (void)drawCircle
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 10, 200, 100)];
    
    CGContextAddPath(context, path.CGPath);
    
    CGContextStrokePath(context);
}

- (void)drawRectangle
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(10, 10, 200, 200)];
    
    path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(10, 10, 200, 200) cornerRadius:20];
    
    CGContextAddPath(context, path.CGPath);
    
    CGContextStrokePath(context);
}

- (void)drawSupernene
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGPoint startP = CGPointMake(10, 10);
    
    [path moveToPoint:startP];
    
    [path addLineToPoint:CGPointMake(125, 125)];
    
    [path addLineToPoint:CGPointMake(240, 10)];
    
    [path closePath];
    
    CGContextAddPath(context, path.CGPath);
    
    [[UIColor blueColor] setFill];
    [[UIColor redColor] setStroke];
    
    CGContextSetLineWidth(context, 15);
    
    CGContextDrawPath(context, kCGPathFillStroke);
}
@end
