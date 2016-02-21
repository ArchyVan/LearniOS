//
//  WheelButton.m
//  Wheel
//
//  Created by Archy on 15/5/22.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "WheelButton.h"

@implementation WheelButton
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = 40;
    CGFloat imageH = 47;
    CGFloat imageX = (contentRect.size.width - imageW) * 0.5;
    CGFloat imageY = 20;
    return CGRectMake(imageX, imageY, imageW, imageH);
}
- (void)setHighlighted:(BOOL)highlighted
{
    
}

@end
