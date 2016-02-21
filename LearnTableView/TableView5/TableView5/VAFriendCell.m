//
//  VAFriendCell.m
//  TableView5
//
//  Created by MS on 15-5-6.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "VAFriendCell.h"
#import "VAFriend.h"
@implementation VAFriendCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString * ID = @"friend";
    VAFriendCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[VAFriendCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
-(void)setFriendData:(VAFriend *)friendData
{
    _friendData = friendData;
    
    self.imageView.image = [UIImage imageNamed:friendData.icon];
    self.textLabel.text = friendData.name;
    self.textLabel.textColor = friendData.isVip ?[UIColor redColor] : [UIColor blackColor];
    self.detailTextLabel.text = friendData.intro;
}
@end
