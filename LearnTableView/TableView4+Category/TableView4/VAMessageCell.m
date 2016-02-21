//
//  VAMessageCell.m
//  TableView4
//
//  Created by MS on 15-5-5.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "VAMessageCell.h"
#import "VAMessage.h";
#import "VAMessageFrame.h"
#import "UIImage+Extension.h"

@interface VAMessageCell ()

@property (nonatomic, weak)UILabel * timeView;

@property (nonatomic, weak)UIImageView * iconView;

@property (nonatomic, weak)UIButton * textView;

@end

@implementation VAMessageCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString * ID = @"message";
    VAMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[VAMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UILabel * timeView = [[UILabel alloc]init];
        
        timeView.textAlignment = NSTextAlignmentCenter;
        timeView.textColor = [UIColor grayColor];
        
        timeView.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:timeView];
        self.timeView = timeView;
        
        UIImageView * iconView = [[UIImageView alloc]init];
        
        [self.contentView addSubview:iconView];
        
        self.iconView = iconView;
        
        UIButton * textView = [[UIButton alloc]init];
        textView.titleLabel.numberOfLines = 0;
        textView.titleLabel.font = VATextFont;
        
        textView.contentEdgeInsets = UIEdgeInsetsMake(VATextPadding, VATextPadding, VATextPadding, VATextPadding);
        [textView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:textView];
        self.textView = textView;
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

- (void)setMessageFrame:(VAMessageFrame *)messageFrame
{
    _messageFrame = messageFrame;
    
    VAMessage * message = messageFrame.message;
    
    self.timeView.text = message.time;
    self.timeView.frame = messageFrame.timeF;
    
    NSString * icon = (message.type == VAMessageTypeMe)?@"me":@"other";
    
    self.iconView.image = [UIImage imageNamed:icon];
    self.iconView.frame = messageFrame.iconF;
    self.iconView.layer.masksToBounds = YES;
    self.iconView.layer.cornerRadius = 10;
    
    [self.textView setTitle:message.text forState:UIControlStateNormal];
    self.textView.frame = messageFrame.textF;
    
    if (message.type == VAMessageTypeMe) {
        [self.textView setBackgroundImage:[UIImage resizableImage:@"chat_send_nor"] forState:UIControlStateNormal];

    } else {
    
        [self.textView setBackgroundImage:[UIImage resizableImage:@"chat_recive_nor"] forState:UIControlStateNormal];
    }
}

@end
