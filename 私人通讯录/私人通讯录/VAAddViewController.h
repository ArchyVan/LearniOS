//
//  VAAddViewController.h
//  私人通讯录
//
//  Created by MS on 15-5-11.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VAAddViewController,VAContact;

@protocol VAAddViewControllerDelegate <NSObject>

@optional

- (void)addViewController:(VAAddViewController *)addVc didAddContact:(VAContact *)contact;

@end

@interface VAAddViewController : UIViewController

@property (nonatomic,weak) id <VAAddViewControllerDelegate> delegate;


@end
