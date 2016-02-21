//
//  VAKeyboardTool.m
//  PickerView3
//
//  Created by MS on 15-5-9.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "VAKeyboardTool.h"

@implementation VAKeyboardTool

+ (id)keyboardTool
{
    return [[[NSBundle mainBundle]loadNibNamed:@"VAKeyboardTool" owner:nil options:nil]firstObject];
}

- (IBAction)previous {
    
    if ([_delegate respondsToSelector:@selector(keyboardTool:itemClick:)]) {
        [_delegate keyboardTool:self itemClick:VAKeyboardToolItemTypePrevious];
    }
    
}
- (IBAction)next {
    
    if ([_delegate respondsToSelector:@selector(keyboardTool:itemClick:)]) {
        [_delegate keyboardTool:self itemClick:VAKeyboardToolItemTypeNext];
    }
}

- (IBAction)done {
    
    if ([_delegate respondsToSelector:@selector(keyboardTool:itemClick:)]) {
        [_delegate keyboardTool:self itemClick:VAKeyboardToolItemTypeDone];
    }
}
@end
