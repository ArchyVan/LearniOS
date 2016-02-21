//
//  NSString+Extension.h
//  TableView4
//
//  Created by MS on 15-5-5.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
/**
 *  根据字符串自动计算尺寸
 *
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

@end
