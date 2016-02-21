//
//  VATgCell.h
//  TableView2
//
//  Created by MS on 15-5-4.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VATg;

@interface VATgCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) VATg *tg;

@end
