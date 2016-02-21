//
//  VAEditViewController.m
//  私人通讯录
//
//  Created by MS on 15-5-11.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "VAEditViewController.h"
#import "VAContact.h"

@interface VAEditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
- (IBAction)save;
- (IBAction)edit:(UIBarButtonItem *)sender;

@end

@implementation VAEditViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.nameField.text = self.contact.name;
    self.phoneField.text = self.contact.phone;
    
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.phoneField];
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
    self.saveBtn.enabled = (self.nameField.text.length && self.phoneField.text.length);
}




- (IBAction)save {
    [self.navigationController popViewControllerAnimated:YES];
    
    // 2.通知代理
    if ([self.delegate respondsToSelector:@selector(editViewController:didSaveContact:)]) {
        // 更新模型数据
        self.contact.name = self.nameField.text;
        self.contact.phone = self.phoneField.text;
        [self.delegate editViewController:self didSaveContact:self.contact];
    }

    
}

- (IBAction)edit:(UIBarButtonItem *)sender {
    
    if (self.nameField.enabled) {
        self.nameField.enabled = NO;
        self.phoneField.enabled = NO;
        
        [self.view endEditing:YES];
        self.saveBtn.hidden = YES;
        
        sender.title = @"编辑";
        
        self.nameField.text = self.contact.name;
        self.phoneField.text = self.contact.phone;
    } else {
        self.nameField.enabled = YES;
        self.phoneField.enabled = YES;
        [self.phoneField becomeFirstResponder];
        self.saveBtn.hidden = NO;
        
        sender.title = @"取消";
    }
}
@end
