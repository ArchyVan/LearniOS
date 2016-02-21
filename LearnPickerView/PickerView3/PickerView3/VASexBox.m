//
//  VASexBox.m
//  PickerView3
//
//  Created by MS on 15-5-9.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "VASexBox.h"

@implementation VASexBox

- (IBAction)sexChange {
    
    if (_manBtn.enabled) {
        _manBtn.enabled = NO;
        _womanBtn.enabled = YES;
    } else {
        _manBtn.enabled = YES;
        _womanBtn.enabled = NO;
    }
}

+ (id)sexBox
{
    return [[[NSBundle mainBundle]loadNibNamed:@"VASexBox" owner:nil options:nil] firstObject];
}

@end
