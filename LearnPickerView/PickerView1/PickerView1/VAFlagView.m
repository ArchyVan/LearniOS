    //
//  VAFlagView.m
//  PickerView1
//
//  Created by MS on 15-5-9.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "VAFlagView.h"
#import "VAFlag.h"
@interface VAFlagView()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end

@implementation VAFlagView
+ (instancetype)flagViewWithResuingView:(UIView *)resuingView
{
    if (resuingView == nil) {
        return [[[NSBundle mainBundle] loadNibNamed:@"VAFlagView" owner:nil options:nil]lastObject];
    } else {
        return (VAFlagView *)resuingView;
    }
}
- (void)setFlag:(VAFlag *)flag
{
    _flag = flag;
    
    self.nameLabel.text = flag.name;
    
    self.iconView.image = [UIImage imageNamed:flag.icon];
}
+(CGFloat)flagViewHeight
{
    return 44;
}
@end
