//
//  LrcCell.m
//  CustomMusicPlayer
//
//  Created by Archy on 15/6/15.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "LrcCell.h"
#import "LrcLine.h"
@implementation LrcCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"lrc";
    LrcCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LrcCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.numberOfLines = 0;
        self.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabel.frame = self.bounds;
}
- (void)setLrcLine:(LrcLine *)lrcLine
{
    _lrcLine = lrcLine;
    
    self.textLabel.text = lrcLine.word;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
