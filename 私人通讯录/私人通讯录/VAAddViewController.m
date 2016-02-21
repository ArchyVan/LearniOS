//
//  VAAddViewController.m
//  私人通讯录
//
//  Created by MS on 15-5-11.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "VAAddViewController.h"
#import "VAContact.h"
@interface VAAddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

- (IBAction)add;

@end

@implementation VAAddViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.phoneField];
    
    // 退出键盘
    //    [self.nameField resignFirstResponder];
    //    [self.view endEditing:YES];
}

/**
 *  控制器的view完全显示的时候调用
 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 让姓名文本框成为第一响应者(叫出键盘)
    [self.nameField becomeFirstResponder];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  文本框的文字发生改变的时候调用
 */
- (void)textChange
{
    self.addButton.enabled = (self.nameField.text.length && self.phoneField.text.length);
}




- (IBAction)add {
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    if ([self.delegate respondsToSelector:@selector(addViewController:didAddContact:)]) {
        
        VAContact *contact = [[VAContact alloc]init];
        
        contact.name = self.nameField.text;
        contact.phone = self.phoneField.text;
        [self.delegate addViewController:self didAddContact:contact];
    }
}
@end
