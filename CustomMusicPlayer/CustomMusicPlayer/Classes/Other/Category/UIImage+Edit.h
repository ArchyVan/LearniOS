//
//  UIImage+Edit.h
//  QuartzDemo1
//
//  Created by MS on 15/5/14.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Edit)
/**
 *  打水印
 *
 *  @param bg   背景图片
 *  @param logo 右下角的水印图片
 */
+ (instancetype)waterImageWithBackgroundImage:(NSString *)bg logo:(NSString *)logo;
/**
 *  将图片裁剪，并用圆环包围
 */
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

+ (instancetype)imageWithName:(NSString *)name border:(CGFloat)border borderColor:(UIColor *)color;

/**
 *  将屏幕进行截图
 */
+ (instancetype)captureWithView:(UIView *)view;

+ (instancetype)imageWithCaptureView:(UIView *)view;

@end
