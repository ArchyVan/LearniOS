//
//  UIImage+Edit.h
//  
//
//  Created by Archy on 15/6/14.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (Edit)
/**
 *  水印
 */
+ (instancetype)waterImageWithBackgroundImage:(NSString *)bg logoImage:(NSString *)logo;
/**
 *  圆形图
 *
 */
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
/**
 *  截屏
 */
+ (instancetype)captureWithView:(UIView *)view;

@end
