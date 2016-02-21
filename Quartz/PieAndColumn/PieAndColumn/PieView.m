//
//  PieView.m
//  PieAndColumn
//
//  Created by Archy on 15/6/14.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "PieView.h"
#import "UIColor+Random.h"
@implementation PieView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    NSArray *data = @[@25,@36,@39];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGPoint center = CGPointMake(125, 125);
    
    CGFloat radius = 120;
    CGFloat startA = 0;
    CGFloat endA = 0;
    CGFloat angel = 0;
    
    for (NSNumber *number in data) {
        startA = endA;
        angel = number.integerValue / 100 * 2 *M_PI;
        endA = startA + angel;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
        [path addLineToPoint:center];
        
        [[UIColor randomColor] set];
        
        CGContextAddPath(context, path.CGPath);
        
        CGContextFillPath(context);
    }
    
}



@end
