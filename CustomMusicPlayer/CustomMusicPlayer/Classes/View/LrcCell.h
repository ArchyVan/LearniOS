//
//  LrcCell.h
//  CustomMusicPlayer
//
//  Created by Archy on 15/6/15.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LrcLine;
@interface LrcCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) LrcLine *lrcLine;
@end
