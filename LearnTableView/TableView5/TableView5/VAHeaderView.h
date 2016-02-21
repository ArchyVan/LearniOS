//
//  VAHeaderView.h
//  TableView5
//
//  Created by MS on 15-5-6.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VAFriendGroup,VAHeaderView;

@protocol VAHeaderViewDelegate <NSObject>

-(void)headerViewDidClickedNameView:(VAHeaderView *)headerView;

@end


@interface VAHeaderView : UITableViewHeaderFooterView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;
@property (nonatomic,strong)VAFriendGroup * group;
@property (nonatomic,weak)id<VAHeaderViewDelegate>delegate;


@end
