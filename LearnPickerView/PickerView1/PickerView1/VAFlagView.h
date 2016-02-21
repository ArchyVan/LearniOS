//
//  VAFlagView.h
//  PickerView1
//
//  Created by MS on 15-5-9.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VAFlag;

@interface VAFlagView : UIView

@property (nonatomic, strong)VAFlag *flag;

+ (instancetype)flagViewWithResuingView:(UIView *)resuingView;
+ (CGFloat)flagViewHeight;

@end
