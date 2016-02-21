//
//  MusicCell.h
//  CustomMusicPlayer
//
//  Created by Archy on 15/6/15.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Music;
@interface MusicCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (strong, nonatomic) Music *music;

@end
