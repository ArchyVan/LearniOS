//
//  VAMessageFrame.m
//  TableView4
//
//  Created by MS on 15-5-5.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "VAMessageFrame.h"
#import "VAMessage.h"
#import "NSString+Extension.h"
@implementation VAMessageFrame

-(void)setMessage:(VAMessage *)message
{
    _message = message;
    
    CGFloat padding = 10;
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    if (message.hideTime == NO) {
        CGFloat timeX = 0;
        CGFloat timeY = 0;
        CGFloat timeW = screenW;
        CGFloat timeH = 40;
        _timeF = CGRectMake(timeX, timeY, timeW, timeH);
    }
    
    CGFloat iconY = CGRectGetMaxY(_timeF) + padding;
    
    CGFloat iconW = 40;
    CGFloat iconH = 40;
    CGFloat iconX;
    if (message.type == VAMessageTypeOther) {
        iconX = padding;
    } else {
        iconX = screenW - padding - iconW;
    }
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGFloat textY = iconY;
    
    CGSize textMaxSize = CGSizeMake(200, MAXFLOAT);
    CGSize textRealSize = [message.text sizeWithFont:VATextFont maxSize:textMaxSize];
    
    CGSize textBtnSize = CGSizeMake(textRealSize.width + VATextPadding * 2, textRealSize.height + VATextPadding * 2);
    
    CGFloat textX;
    
    if (message.type == VAMessageTypeOther) {
        
        textX = CGRectGetMaxX(_iconF) + padding;
    
    } else {
        
        textX = iconX - padding - textBtnSize.width;
        
    }
    
    _textF = CGRectMake(textX, textY, textBtnSize.width, textBtnSize.height);
    
    CGFloat textMaxY = CGRectGetMaxY(_textF);
    CGFloat iconMaxY = CGRectGetMaxY(_iconF);
    
    _cellHeight = MAX(textMaxY, iconMaxY) + padding;
    
}

@end
