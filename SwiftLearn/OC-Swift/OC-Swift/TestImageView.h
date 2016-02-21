//
//  TestImageView.h
//  OC-Swift
//
//  Created by Archy on 15/6/22.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TestImageView : UIImageView
{
    id _target;
    SEL _sel;
}

- (void)addTarget:(id)target withSelector:(SEL)selector;

@end
