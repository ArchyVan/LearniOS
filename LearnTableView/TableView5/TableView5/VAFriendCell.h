//
//  VAFriendCell.h
//  TableView5
//
//  Created by MS on 15-5-6.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VAFriend;
@interface VAFriendCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong)VAFriend * friendData;

@end
