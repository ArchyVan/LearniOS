//
//  TestImageView.m
//  OC-Swift
//
//  Created by Archy on 15/6/22.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "TestImageView.h"


@implementation TestImageView


- (void)addTarget:(id)target withSelector:(SEL)selector
{
    _target = target;
    _sel = selector;
    self.userInteractionEnabled = YES;
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_target) {
        [_target performSelector:_sel withObject:self];
    }
}
@end
