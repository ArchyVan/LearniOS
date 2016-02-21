//
//  UIImage+Extension.m
//  TableView4
//
//  Created by MS on 15-5-5.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (UIImage *)resizableImage:(NSString *)name
{
    /**
     *  
     直接裁剪为平铺模式
     - (UIImage *)resizableImageWithCapInsets:(UIEdgeInsets)capInsets NS_AVAILABLE_IOS(5_0);
     
     // create a resizable version of this image. the interior is tiled when drawn.
     选定模式进行裁剪
     - (UIImage *)resizableImageWithCapInsets:(UIEdgeInsets)capInsets resizingMode:(UIImageResizingMode)resizingMode NS_AVAILABLE_IOS(6_0);
     
     // the interior is resized according to the resizingMode
     */
    
    UIImage * normal = [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    CGFloat w = normal.size.width * 0.5;
    CGFloat h = normal.size.height * 0.5;
    
    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w) resizingMode:UIImageResizingModeStretch];
}

@end
