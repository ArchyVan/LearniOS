//
//  VACityPicker.h
//  PickerView3
//
//  Created by MS on 15-5-9.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VACityPicker;

@protocol VACityPickerDelegate <NSObject>

@optional
- (void)cityPicker:(VACityPicker *)cityPicker citySelectWithProvince:(NSString *)province city:(NSString *)city;

@end


@interface VACityPicker : UIView

@property (nonatomic, weak)id<VACityPickerDelegate> delegate;

+ (id)cityPicker;

@end
