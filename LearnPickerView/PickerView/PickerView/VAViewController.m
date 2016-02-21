//
//  VAViewController.m
//  PickerView
//
//  Created by MS on 15-5-9.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "VAViewController.h"

@interface VAViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UILabel *fruitLabel;

@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UILabel *drinkLabel;
- (IBAction)randomFood:(id)sender;
@property (nonatomic,strong)NSArray * foods;
@end

@implementation VAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    for (int component = 0; component < self.foods.count; component++) {
        [self pickerView:nil didSelectRow:0 inComponent:component];
    }
}
-(NSArray *)foods
{
    if (_foods == nil) {
        _foods = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"foods" ofType:@"plist"]];
    }
    return _foods;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.foods.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray * subfoods = self.foods[component];
    return subfoods.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.foods[component][row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (0 == component) {
        self.fruitLabel.text = self.foods[component][row];
    } else if (1 == component){
        self.mainLabel.text = self.foods[component][row];
    } else if (2 == component){
        self.drinkLabel.text = self.foods[component][row];
    }
}

- (IBAction)randomFood:(id)sender {
    
    for (int component = 0; component < self.foods.count; component++) {
        
        int count = [self.foods[component] count];
        
        int oldRow = [self.pickerView selectedRowInComponent:component];
        
        int row = oldRow;
        
        while (row == oldRow) {
            
            row = arc4random_uniform(count);
            
        }
        
        [self.pickerView selectRow:row inComponent:component animated:YES];
        
        [self pickerView:nil didSelectRow:row inComponent:component];
    }
    
}
@end
