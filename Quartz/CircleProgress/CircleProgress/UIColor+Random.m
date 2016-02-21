//
//  UIColor+Random.m
//  CircleProgress
//
//  Created by Archy on 15/6/14.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "UIColor+Random.h"

@implementation UIColor (Random)

+ (UIColor *)randomColor
{
    CGFloat red = arc4random_uniform(256) / 255.0;
    CGFloat green = arc4random_uniform(256) / 255.0;
    CGFloat blue = arc4random_uniform(256) / 255.0;;
    
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1];
    
    return color;
}

@end
