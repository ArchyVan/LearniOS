//
//  VAKeyboardTool.h
//  PickerView3
//
//  Created by MS on 15-5-9.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VAKeyboardTool;

typedef enum{
    VAKeyboardToolItemTypePrevious,
    VAKeyboardToolItemTypeNext,     VAKeyboardToolItemTypeDone
} VAKeyboardToolItemType;

@protocol VAKeyboardToolDelegate <NSObject>

@optional
- (void)keyboardTool:(VAKeyboardTool *)keyboardTool itemClick:(VAKeyboardToolItemType)itemType;

@end


@interface VAKeyboardTool : UIView
- (IBAction)previous;

- (IBAction)next;
- (IBAction)done;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *previousItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextItem;

@property (nonatomic, weak)id<VAKeyboardToolDelegate> delegate;

+ (id)keyboardTool;
@end
