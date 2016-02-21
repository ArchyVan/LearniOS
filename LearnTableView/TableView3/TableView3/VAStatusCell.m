//
//  VAStatusCell.m
//  TableView3
//
//  Created by MS on 15-5-5.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#define VANameFont [UIFont systemFontOfSize:14]

#define VATextFont [UIFont systemFontOfSize:15]

#import "VAStatusCell.h"
#import "VAStatus.h"
#import "VAStatusFrame.h"

@interface VAStatusCell ()

@property (nonatomic, weak) UIImageView * iconView;

@property (nonatomic, weak) UILabel * nameView;

@property (nonatomic, weak) UIImageView * vipView;

@property (nonatomic, weak) UILabel * textView;


@property (nonatomic, weak) UIImageView * pictureView;

@end

@implementation VAStatusCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        UIImageView * iconView = [[UIImageView alloc]init];
        
        [self.contentView addSubview:iconView];
        
        self.iconView = iconView;
        
        
        UILabel * nameView = [[UILabel alloc]init];
        nameView.font = VANameFont;
        [self.contentView addSubview:nameView];
        
        self.nameView = nameView;
        
        
        UIImageView * vipView = [[UIImageView alloc]init];
        vipView.image = [UIImage imageNamed:@"vip"];
        [self.contentView addSubview:vipView];
        
        self.vipView = vipView;
        
        UILabel * textView = [[UILabel alloc]init];
        textView.numberOfLines = 0;
        textView.font = VATextFont;
        [self.contentView addSubview:textView];
        
        self.textView = textView;
        
        UIImageView * pictureView = [[UIImageView alloc]init];
        
        [self.contentView addSubview:pictureView];
        
        self.pictureView = pictureView;
        
    }
    return self;
}

-(void)setStatusFrame:(VAStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    [self settingData];
    
    [self settingFrame];
}
- (void)settingData
{
    VAStatus * status = self.statusFrame.status;
    
    self.iconView.image = [UIImage imageNamed:status.icon];
    
    self.nameView.text = status.name;
    
    if (status.vip) {
        self.vipView.hidden = NO;
        
        self.nameView.textColor = [UIColor redColor];
    } else {
        self.vipView.hidden = YES;
        
        self.nameView.textColor = [UIColor blackColor];
    }
    self.textView.text = status.text;
    
    if (status.picture) {
        self.pictureView.hidden = NO;
        self.pictureView.image = [UIImage imageNamed:status.picture];
    } else {
        self.pictureView.hidden = YES;
    }
}

- (void)settingFrame
{
    self.iconView.frame = self.statusFrame.iconF;
    
    self.nameView.frame = self.statusFrame.nameF;
    
    self.vipView.frame = self.statusFrame.vipF;
    
    self.textView.frame = self.statusFrame.textF;
    
    if (self.statusFrame.status.picture) {
        
        self.pictureView.frame = self.statusFrame.pictureF;
    }
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString * ID = @"status";
    VAStatusCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        cell = [[VAStatusCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    return cell;
}
@end
