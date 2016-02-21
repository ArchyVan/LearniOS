//
//  VAFooterView.h
//  TableView2
//
//  Created by MS on 15-5-4.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VAFooterView;

@protocol VAFooterViewDelegate <NSObject>

@optional

- (void)footerViewDidClickedLoadButton:(VAFooterView *)vaFooterView;

@end


@interface VAFooterView : UIView

+ (instancetype)footerView;

@property (nonatomic,weak)id <VAFooterViewDelegate> delegate;

@end
