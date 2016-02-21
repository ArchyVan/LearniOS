//
//  ViewController.m
//  AddressBookUI
//
//  Created by Archy on 15/6/21.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"
#import <AddressBookUI/AddressBookUI.h>

@interface ViewController ()<ABPeoplePickerNavigationControllerDelegate>

@end

@implementation ViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    ABPeoplePickerNavigationController *peopleController = [[ABPeoplePickerNavigationController alloc] init];
    
    peopleController.peoplePickerDelegate = self;
    
    [self presentViewController:peopleController animated:YES completion:nil];
    
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    NSLog(@"%s",__func__);
    
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}
//  在iOS7时 , 选中某一个联系人就会调用
// 返回一个BOOL值, 如果返回NO, 代表不会进入下一层(详情), 如果返回YES,代表会进入下一层
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    NSLog(@"%s",__func__);
    
    /*
     //取出当前联系人的的电话信息
     // 获取练习人得姓名
     CFStringRef lastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
     CFStringRef firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
     NSLog(@"%@ %@", firstName, lastName);
     // 获取联系人的电话
     // 从联系人中获取到得电话是所有的电话
     ABMultiValueRef phones =   ABRecordCopyValue(person, kABPersonPhoneProperty);
     // 获取当前联系人总共有多少种电话
     CFIndex phoneCount = ABMultiValueGetCount(phones);
     
     for (int i = 0; i < phoneCount; i++) {
     CFStringRef name = ABMultiValueCopyLabelAtIndex(phones, i);
     // 从所有的电话中取出指定的电话
     CFStringRef value =  ABMultiValueCopyValueAtIndex(phones, i);
     NSLog(@"name = %@ value = %@", name, value);
     }
     */
    
    return YES;
}
//  在iOS7时 , 选中某一个联系人的某一个属性时就会调用
// 返回一个BOOL值, 如果返回NO, 代表不会进行下一步操作(打电话, 打开日历....), 如果返回YES,代表会进行下一步操作
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    return YES;
}
#pragma mark - iOS8
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person
{
    NSLog(@"%s",__func__);
}
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    NSLog(@"%s",__func__);
}
@end
