//
//  ColumnView.m
//  PieAndColumn
//
//  Created by Archy on 15/6/14.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ColumnView.h"
#import "UIColor+Random.h"
@implementation ColumnView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    NSArray *data = @[@25,@25,@50];
    NSInteger count = data.count;
    
    CGFloat w = rect.size.width / (2 * count - 1);
    CGFloat h = 0;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat viewH = rect.size.height;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (NSInteger i = 0; i < count; i++) {
        h = viewH * [data[i] integerValue] / 100.0;
        x = 2 * w * i;
        y = viewH - h;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(x, y, w, h)];
        
        CGContextAddPath(context, path.CGPath);
        
        [[UIColor randomColor] set];
        
        CGContextFillPath(context);
    }
    
}



@end
