//
//  ProgressView.m
//  CircleProgress
//
//  Created by Archy on 15/6/14.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ProgressView.h"
#import "UIColor+Random.h"
@interface ProgressView ()

@property (nonatomic, weak) UILabel *label;

@end

@implementation ProgressView

- (UILabel *)label
{
    if (!_label) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        
        label.textAlignment = NSTextAlignmentCenter;
        
        
        [self addSubview:label];
        _label = label;
    }
    return _label;
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    self.label.text = [NSString stringWithFormat:@"%.2f%%",progress * 100];
    
    [self setNeedsDisplay];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGPoint center = CGPointMake(50, 50);
    
    CGFloat radius = 48;
    CGFloat startA = -M_PI_2;
    CGFloat endA = -M_PI_2 + _progress * M_PI * 2;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    
    [[UIColor randomColor] set];
    
    CGContextSetLineWidth(context, 3);
    
    CGContextAddPath(context, path.CGPath);
    
    CGContextStrokePath(context);
    
}

@end
