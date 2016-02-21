//
//  UIImage+Edit.m
//  
//
//  Created by Archy on 15/6/14.
//
//

#import "UIImage+Edit.h"

@implementation UIImage (Edit)

+(instancetype)waterImageWithBackgroundImage:(NSString *)bg logoImage:(NSString *)logo
{
    UIImage *bgImage = [UIImage imageNamed:bg];
    
    UIGraphicsBeginImageContextWithOptions(bgImage.size, NO, 0.0);
    
    [bgImage drawInRect:CGRectMake(0, 0, bgImage.size.width, bgImage.size.height)];
    
    UIImage *waterImage = [UIImage imageNamed:logo];
    
    CGFloat scale = 0.2;
    CGFloat margin = 5;
    CGFloat waterW = waterImage.size.width * scale;
    CGFloat waterH = waterImage.size.height * scale;
    CGFloat waterX = bgImage.size.width - waterW - margin;
    CGFloat waterY = bgImage.size.height - waterH - margin;
    
    [waterImage drawInRect:CGRectMake(waterX, waterY, waterW, waterH)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}


+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    UIImage *oldImage = [UIImage imageNamed:name];
    
    CGFloat imageW = oldImage.size.width + 2 * borderWidth;
    CGFloat imageH = oldImage.size.height + 2 * borderWidth;
    
    CGFloat circleW = imageW > imageH ? imageH:imageW;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(circleW, circleW), NO, 0.0);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, circleW, circleW)];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextAddPath(context, path.CGPath);
    
    [borderColor set];
    
    CGContextFillPath(context);
    
    CGRect clipR = CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height);
    
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:clipR];
    
    [clipPath addClip];
    
    [oldImage drawAtPoint:CGPointMake(borderWidth, borderWidth)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return  newImage;
}

+(instancetype)captureWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:context];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end

























