//
//  VAEditViewController.h
//  私人通讯录
//
//  Created by MS on 15-5-11.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VAContact,VAEditViewController;

@protocol VAEditViewControllerDelegate <NSObject>

@optional
- (void)editViewController:(VAEditViewController *)editVc didSaveContact:(VAContact *)contact;

@end

@interface VAEditViewController : UIViewController

@property (nonatomic, strong)VAContact *contact;

@property (nonatomic, weak)id <VAEditViewControllerDelegate> delegate;

@end
