//
//  VAFooterView.m
//  TableView2
//
//  Created by MS on 15-5-4.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "VAFooterView.h"

@interface VAFooterView ()
- (IBAction)loadBtnClick;

@property (weak, nonatomic) IBOutlet UIButton *loadBtn;

@property (weak, nonatomic) IBOutlet UIView *loadingView;

@end

@implementation VAFooterView
+ (instancetype)footerView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"VAFooterView" owner:nil options:nil] lastObject];
}
-(IBAction)loadBtnClick
{
    self.loadBtn.hidden = YES;
    
    self.loadingView.hidden = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(footerViewDidClickedLoadButton:)]) {
            [self.delegate footerViewDidClickedLoadButton:self];
        }
        
        self.loadBtn.hidden = NO;
        
        self.loadingView.hidden = YES;
    });
}
@end
