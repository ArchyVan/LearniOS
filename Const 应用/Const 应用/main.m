//
//  main.m
//  Const 应用
//
//  Created by Archy on 15/6/24.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Const.h"

void testPointerConst();
void testPointer();
void testConstInt();


int main(int argc, const char * argv[]) {
    @autoreleasepool {

        NSLog(@"%@",Appkey);
    
    }
    return 0;
}

void testPointerConst()
{
    int age = 20;
    int num = 30;
    
    const int *p1 = &age;
    int const *p2 = &age;
    int * const p3 = &age;
    
//    *p1 = 40;
//    *p2 = 50;
//    *p3 = 60;
    
//    p1 = &num;
//    p2 = &num;
//    p3 = &num;
    
}

void testPointer()
{
    int age = 20;
    
    int *p = &age;
    *p = 30;
    
    int num = 100;
    p = &num;
    *p = 40;
    
    NSLog(@"%d %d",age,num);
}

void testConstInt()
{
    const int age1 = 20;
    int const age2 = 30;
    
    
}