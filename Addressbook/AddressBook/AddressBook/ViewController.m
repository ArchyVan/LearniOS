//
//  ViewController.m
//  AddressBook
//
//  Created by Archy on 15/6/20.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"
#import <AddressBook/AddressBook.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
        return;
    }
    
    ABAddressBookRef book = ABAddressBookCreateWithOptions(NULL, NULL);
    
    ABAddressBookRequestAccessWithCompletion(book, ^(bool granted, CFErrorRef error) {
        
        if (granted) {
            NSLog(@"授权成功");
        } else {
            NSLog(@"授权失败");
        }
    });
    
}
- (void)readRecord
{
    if (ABAddressBookGetAuthorizationStatus() != kABAuthorizationStatusAuthorized) {
        return;
    }
    
    ABAddressBookRef book = ABAddressBookCreateWithOptions(NULL, NULL);
    
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(book);
    
    CFIndex count = CFArrayGetCount(allPeople);
    
    for (int i = 0; i < count; i++) {
        ABRecordRef people = CFArrayGetValueAtIndex(allPeople, i);
        
        CFStringRef lastName = ABRecordCopyValue(people, kABPersonLastNameProperty);
        CFStringRef firstName = ABRecordCopyValue(people, kABPersonFirstNameProperty);
        
        NSLog(@"%@ %@", firstName, lastName);

        ABMultiValueRef phones = ABRecordCopyValue(people, kABPersonPhoneProperty);
        
        CFIndex phoneCount = ABMultiValueGetCount(phones);
        
        for (int i = 0; i < phoneCount; i++) {
            CFStringRef name = ABMultiValueCopyLabelAtIndex(phones, i);
            
            CFStringRef value = ABMultiValueCopyValueAtIndex(phones, i);
            
            NSLog(@"name = %@ value = %@",name,value);
        }
    }
}

- (void)addRecord
{
    ABRecordRef people = ABPersonCreate();
    
    ABRecordSetValue(people, kABPersonLastNameProperty, @"Ice", NULL);
    
    ABRecordSetValue(people, kABPersonFirstNameProperty, @"Archy", NULL);
    
    ABMultiValueRef phones = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    
    ABMultiValueAddValueAndLabel(phones, @"13545665789", kABPersonPhoneMainLabel, NULL);
    
    ABMultiValueAddValueAndLabel(phones, @"88888888", kABPersonPhoneHomeFAXLabel, NULL);
    
    ABAddressBookRef book = ABAddressBookCreateWithOptions(NULL, NULL);
    
    ABAddressBookAddRecord(book, people, NULL);
    
    ABAddressBookSave(book, NULL);
}
- (void)updateRecord
{
    if (ABAddressBookGetAuthorizationStatus() != kABAuthorizationStatusAuthorized) {
        return;
    }
    
    ABAddressBookRef book = ABAddressBookCreateWithOptions(NULL, NULL);
    
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(book);
    
    ABRecordRef people = CFArrayGetValueAtIndex(allPeople, 0);
    
    ABRecordSetValue(people, kABPersonLastNameProperty, @"Archy", NULL);
    
    ABAddressBookSave(book, NULL);
}
@end
