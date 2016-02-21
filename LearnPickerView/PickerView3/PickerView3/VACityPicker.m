//
//  VACityPicker.m
//  PickerView3
//
//  Created by MS on 15-5-9.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "VACityPicker.h"
#import "VAProvince.h"

@interface VACityPicker () <UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSMutableArray *_provinces;
}
@end

@implementation VACityPicker

+ (id)cityPicker
{
    return [[NSBundle mainBundle]loadNibNamed:@"VACityPicker" owner:nil options:nil][0];
}

- (void)awakeFromNib
{
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"cities.plist" ofType:nil]];
    
    _provinces = [NSMutableArray array];
    
    for (NSDictionary *dict in array) {
        
        VAProvince *p = [VAProvince provinceWithDict:dict];
        
        [_provinces addObject:p];
        
    }
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (0 == component) {
        return _provinces.count;
    } else {
        NSInteger pIndex = [pickerView selectedRowInComponent:0];
        
        VAProvince *p = _provinces[pIndex];
        
        return p.cities.count;
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (0 == component) {
        
        VAProvince * p = _provinces[row];
        
        return p.name;
    } else {
        NSInteger pIndex = [pickerView selectedRowInComponent:0];
        
        VAProvince *p = _provinces[pIndex];
        
        return p.cities[row];
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (0 == component) {
        [pickerView reloadComponent:1];
        
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
    
    NSInteger pIndex = [pickerView selectedRowInComponent:0];
    
    VAProvince * p = _provinces[pIndex];
    
    NSInteger cIndex = [pickerView selectedRowInComponent:1];
    
    if ([_delegate respondsToSelector:@selector(cityPicker:citySelectWithProvince:city:)]) {
        [_delegate cityPicker:self citySelectWithProvince:p.name city:p.cities[cIndex]];
    }
}
@end
