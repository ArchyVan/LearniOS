//
//  VAContactCell.m
//  私人通讯录
//
//  Created by MS on 15-5-12.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "VAContactCell.h"
#import "VAContact.h"

@interface VAContactCell ()
@property (nonatomic, weak) UIView * divider;

@end


@implementation VAContactCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"contact";
    
    return [tableView dequeueReusableCellWithIdentifier:ID];
}

- (void)awakeFromNib
{
    UIView *divider = [[UIView alloc]init];
    
    divider.backgroundColor = [UIColor blackColor];
    divider.alpha = 0.2;
    [self.contentView addSubview:divider];
    self.divider = divider;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat dividerX = 0;
    CGFloat dividerH = 1;
    CGFloat dividerY = self.frame.size.height - dividerH;
    CGFloat dividerW = self.frame.size.width;
    self.divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
}
- (void)setContact:(VAContact *)contact
{
    _contact = contact;
    
    self.textLabel.text = contact.name;
    self.detailTextLabel.text = contact.phone;
}

@end
