//
//  VAViewController.m
//  PickerView2
//
//  Created by MS on 15-5-9.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "VAViewController.h"
#import "VAProvince.h"
@interface VAViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSMutableArray * _provinces;
}

@end

@implementation VAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray * array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"cities.plist" ofType:nil]];
    
    _provinces = [NSMutableArray array];
    for (NSDictionary * dict in array) {
        VAProvince *p = [VAProvince provinceWithDict:dict];
        [_provinces addObject:p];
    }
	
    UIPickerView *pickerView = [[UIPickerView alloc]init];
    
    pickerView.dataSource = self;
    
    pickerView.delegate = self;
    
    pickerView.showsSelectionIndicator = YES;
    
    
    [self.view addSubview:pickerView];
    
    [self pickerView:nil didSelectRow:0 inComponent:0];
    
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
        int pIndex = [pickerView selectedRowInComponent:0];
        
        VAProvince * province = _provinces[pIndex];
        
        return province.cities.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (0 == component) {
        VAProvince * p = _provinces[row];
        
        return p.name;
    } else {
        int pIndex = [pickerView selectedRowInComponent:0];
        
        VAProvince *p = _provinces[pIndex];
        
        NSLog(@"%@",p.cities[row]);
        return p.cities[row];
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (0 == component) {
        [pickerView reloadComponent:1];
        
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
    
}
@end
