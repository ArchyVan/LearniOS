//
//  VAStatusCell.h
//  TableView3
//
//  Created by MS on 15-5-5.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VAStatusFrame;

@interface VAStatusCell : UITableViewCell

@property (nonatomic,strong)VAStatusFrame * statusFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
