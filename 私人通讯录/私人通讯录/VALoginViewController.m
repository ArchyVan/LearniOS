//
//  VALoginViewController.m
//  私人通讯录
//
//  Created by MS on 15-5-11.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "VALoginViewController.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
@interface VALoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UISwitch *rmbpwdSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *autologinSwitch;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)rmbpwdChange;

- (IBAction)autologinChange;
- (IBAction)login;

@end

@implementation VALoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    
    self.accountField.keyboardType = UIKeyboardTypeAlphabet;
    self.passwordField.keyboardType = UIKeyboardTypeNumberPad;
    
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.accountField];
    
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.passwordField];
    
    
}

-(void)textChange
{
    self.loginButton.enabled = (self.accountField.text.length && self.passwordField.text.length);
}

- (IBAction)rmbpwdChange {
    if (self.rmbpwdSwitch.isOn == NO) {
        self.autologinSwitch.on = NO;
    }
    
}

- (IBAction)autologinChange {
    
    if (self.autologinSwitch) {
        
        self.rmbpwdSwitch.on = YES;
    }
}

- (IBAction)login {
    
    if (![self.accountField.text isEqualToString:@"va"]) {
        [MBProgressHUD showError:@"账号错误"];
        return;
    }
    if (![self.passwordField.text isEqualToString:@"123"]) {
        [MBProgressHUD showError:@"密码错误"];
        return;
    }
    
    [MBProgressHUD showMessage:@"小范正在帮你加载"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        [MBProgressHUD hideHUD];
        
        [self performSegueWithIdentifier:@"login2contacts" sender:nil];
        
    });
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController * viewController = segue.destinationViewController;
    
    viewController.title = [NSString stringWithFormat:@"%@的联系人列表",self.accountField.text];
}
@end
