//
//  CopyImageView.m
//  CustomImageView
//
//  Created by Archy on 15/6/14.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "CopyImageView.h"

@implementation CopyImageView


- (void)setImage:(UIImage *)image
{
    _image = image;
    
    [self setNeedsDisplay];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [_image drawInRect:rect];
    
}





@end
