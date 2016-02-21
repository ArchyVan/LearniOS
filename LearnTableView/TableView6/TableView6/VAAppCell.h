//
//  VAAppCell.h
//  TableView6
//
//  Created by MS on 15-5-8.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VAApp,VAAppCell;

@protocol VAAppCellDelegate <NSObject>

@optional
- (void)appCellDidClickedDownloadButton:(VAAppCell *)cell;

@end

@interface VAAppCell : UITableViewCell

@property (nonatomic, strong)VAApp *app;

@property (nonatomic, weak)id<VAAppCellDelegate> delegate;

@end
