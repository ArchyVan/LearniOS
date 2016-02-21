//
//  ViewController.m
//  01-UIAlertController
//
//  Created by apple on 14/12/2.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "ViewController.h"
#import "HMAlertViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"你有严重的精神病,赶紧去治疗" preferredStyle:UIAlertControllerStyleActionSheet];
    // 设置popover指向的item
    alert.popoverPresentationController.barButtonItem = self.navigationItem.leftBarButtonItem;
    
    // 添加按钮
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        NSLog(@"点击了确定按钮");
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"点击了取消按钮");
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}
// UIAlertControllerStyleActionSheet的使用注意
// 1.不能有文本框
// 2.在iPad中,必须使用popover的形式展示

// Text fields can only be added to an alert controller of style UIAlertControllerStyleAlert
// 只能在UIAlertControllerStyleAlert样式的view上添加文本框

- (void)alertController
{
    // 危险操作:弹框提醒
    // 1.UIAlertView
    // 2.UIActionSheet
    // iOS8开始:UIAlertController == UIAlertView + UIActionSheet
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"你有严重的精神病,赶紧去治疗" preferredStyle:UIAlertControllerStyleAlert];
    
    // 添加按钮
    __weak typeof(alert) weakAlert = alert;
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        NSLog(@"点击了确定按钮--%@-%@", [weakAlert.textFields.firstObject text], [weakAlert.textFields.lastObject text]);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"点击了取消按钮");
    }]];
    //    [alert addAction:[UIAlertAction actionWithTitle:@"其它" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    //        NSLog(@"点击了其它按钮");
    //    }]];
    
    // 添加文本框
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.textColor = [UIColor redColor];
        textField.text = @"123";
        [textField addTarget:self action:@selector(usernameDidChange:) forControlEvents:UIControlEventEditingChanged];
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(usernameDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.secureTextEntry = YES;
        textField.text = @"123";
    }];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)usernameDidChange:(UITextField *)username
{
    NSLog(@"%@", username.text);
}

- (void)actionSheet
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"警告:你有严重的精神病,赶紧去治疗" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定"
                                              otherButtonTitles:@"关闭", nil];
    [sheet showInView:self.view];
}

- (void)alertView
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"你有严重的精神病,赶紧去治疗" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [alert show];
}

@end
