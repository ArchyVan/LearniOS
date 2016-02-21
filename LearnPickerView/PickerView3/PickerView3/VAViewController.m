//
//  VAViewController.m
//  PickerView3
//
//  Created by MS on 15-5-9.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "VAViewController.h"
#import "VASexBox.h"
#import "VAKeyboardTool.h"
#import "VACityPicker.h"
@interface VAViewController ()<UITextFieldDelegate,VACityPickerDelegate,VAKeyboardToolDelegate>
{
    NSMutableArray * _fields;
    UITextField * _focusedField;
    VAKeyboardTool * _tool;
}

@end

@implementation VAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self settingKeyboard];
    
    [self addSexBox];
    
    [self dealFields];
    
    [self addKeyboardNote];
    
}
- (void)addKeyboardNote
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}
- (void)keyboardWillShow:(NSNotification *)note
{
    CGFloat fieldMaxY = CGRectGetMaxY(_focusedField.frame);
    
    
    CGFloat keyboardH = [note.userInfo [UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    CGFloat keyboardY = self.view.frame.size.height - keyboardH;
    
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    
    if (duration <= 0) {
        duration = 0.25;
    }
    
    [UIView animateWithDuration:duration animations:^{
        if (fieldMaxY > keyboardY) {
            self.view.transform = CGAffineTransformMakeTranslation(0, keyboardY - fieldMaxY - 10);
        } else {
            self.view.transform = CGAffineTransformIdentity;
        }
    }];
    
}

- (void)keyboardWillHide:(NSNotification *)note
{
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}
- (void)dealFields
{
    _fields = [NSMutableArray array];
    
    VAKeyboardTool * tool = [VAKeyboardTool keyboardTool];
    tool.delegate = self;
    
    for (UIView * child in self.view.subviews) {
        if ([child isKindOfClass:[UITextField class]]) {
            UITextField * field = (UITextField *)child;
            
            field.inputAccessoryView = tool;
            
            field.delegate = self;
            
            [_fields addObject:field];
        }
    }
    _tool = tool;
    
    [_fields sortUsingComparator:^NSComparisonResult(UITextField * obj1, UITextField * obj2) {
        CGFloat obj1Y = obj1.frame.origin.y;
        CGFloat obj2Y = obj2.frame.origin.y;
        if (obj1Y > obj2Y) {
            return NSOrderedDescending;
        } else {
            return NSOrderedAscending;
        }
        
    }];
    
}

- (void)addSexBox
{
    VASexBox * sexBox = [VASexBox sexBox];
    sexBox.center = CGPointMake(150, 143);
    [self.view addSubview:sexBox];
}
- (void)settingKeyboard
{
    UIDatePicker * datePicker = [[UIDatePicker alloc]init];
    
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.locale =[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    [datePicker addTarget:self action:@selector(birthdayChange:) forControlEvents:UIControlEventValueChanged];
    
    _birthdayField.inputView = datePicker;
    
    VACityPicker *cityPicker = [VACityPicker cityPicker];
    
    cityPicker.delegate =self;
    _cityField.inputView = cityPicker;
    
}

-(void)keyboardTool:(VAKeyboardTool *)keyboardTool itemClick:(VAKeyboardToolItemType)itemType
{
    if (itemType == VAKeyboardToolItemTypeDone) {
        [self.view endEditing:YES];
    } else {
        NSInteger index = [_fields indexOfObject:_focusedField];
        
        if (itemType == VAKeyboardToolItemTypeNext) {
            index++;
        } else {
            index--;
        }
        [_fields[index] becomeFirstResponder];
    }
}
-(void)cityPicker:(VACityPicker *)cityPicker citySelectWithProvince:(NSString *)province city:(NSString *)city
{
    _cityField.text = [NSString stringWithFormat:@"%@ %@",province,city];
}

- (void)birthdayChange:(UIDatePicker *)picker
{
    NSDateFormatter * fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString * time = [fmt stringFromDate:picker.date];
    
    _birthdayField.text = time;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    _focusedField =textField;
    
    NSInteger index = [_fields indexOfObject:textField];
    
    _tool.previousItem.enabled = index!= 0;
    
    _tool.nextItem.enabled = index != (_fields.count-1);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return !(textField == _birthdayField || textField == _birthdayField);
}
@end
