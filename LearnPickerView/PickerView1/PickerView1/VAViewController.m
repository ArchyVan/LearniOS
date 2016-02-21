//
//  VAViewController.m
//  PickerView1
//
//  Created by MS on 15-5-9.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "VAViewController.h"
#import "VAFlag.h"
#import "VAFlagView.h"
@interface VAViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, strong) NSArray *flags;
@end

@implementation VAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}
-(NSArray *)flags
{
    if (_flags == nil) {
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"flags.plist" ofType:nil]];
        NSMutableArray *flagArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            VAFlag *flag = [VAFlag flagWithDict:dict];
            [flagArray addObject:flag];
        }
        _flags = flagArray;
    }
    return _flags;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.flags.count;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    VAFlagView *flagView = [VAFlagView flagViewWithResuingView:view];
    
    flagView.flag = self.flags[row];
    
    return flagView;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return [VAFlagView flagViewHeight];
}
@end
