//
//  VAStatusFrame.m
//  TableView3
//
//  Created by MS on 15-5-5.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#define VANameFont [UIFont systemFontOfSize:14]

#define VATextFont [UIFont systemFontOfSize:15]

#import "VAStatusFrame.h"
#import "VAStatus.h"
@implementation VAStatusFrame

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


-(void)setStatus:(VAStatus *)status
{
    _status = status;
    
    
    CGFloat padding = 10;
    
    CGFloat iconX = padding;
    CGFloat iconY = padding;
    CGFloat iconW = 30;
    CGFloat iconH = 30;
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGSize nameSize = [self sizeWithText:self.status.name font:VANameFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    
    CGFloat nameX = CGRectGetMaxX(_iconF) +padding;
    CGFloat nameY = iconY + (iconH - nameSize.height)*0.5;
    
    _nameF = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    
    CGFloat vipX = CGRectGetMaxX(_nameF) + padding;
    CGFloat vipY = nameY;
    CGFloat vipW = 14;
    CGFloat vipH = 14;
    _vipF = CGRectMake(vipX, vipY, vipW, vipH);
    
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(_iconF) + padding;
    CGSize textSize = [self sizeWithText:self.status.text font:VATextFont maxSize:CGSizeMake(300, MAXFLOAT)];
    _textF = CGRectMake(textX, textY, textSize.width, textSize.height);
    
    if (self.status.picture) {
        CGFloat pictureX = textX;
        CGFloat pictureY = CGRectGetMaxY(_textF) + padding;
        CGFloat pictureW = 100;
        CGFloat pictureH = 100;
        _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
        _cellHeight = CGRectGetMaxY(_pictureF) + padding;
    } else {
        _cellHeight = CGRectGetMaxY(_textF) + padding;
    }
}
@end
