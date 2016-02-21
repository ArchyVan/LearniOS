//
//  VAContactCell.h
//  私人通讯录
//
//  Created by MS on 15-5-12.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VAContact;
@interface VAContactCell : UITableViewCell

@property (nonatomic, strong)VAContact * contact;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
