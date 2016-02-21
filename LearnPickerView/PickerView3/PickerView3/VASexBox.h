//
//  VASexBox.h
//  PickerView3
//
//  Created by MS on 15-5-9.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VASexBox : UIView
@property (weak, nonatomic) IBOutlet UIButton *manBtn;
@property (weak, nonatomic) IBOutlet UIButton *womanBtn;
- (IBAction)sexChange;


+ (id)sexBox;
@end
