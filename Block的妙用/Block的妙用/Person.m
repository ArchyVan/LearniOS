//
//  Person.m
//  Block的妙用
//
//  Created by Archy on 15/6/11.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "Person.h"

@implementation Person

- (Person *(^)(NSString *))study
{
    return ^(NSString *name){
        NSLog(@"study---%@",name);
        return self;
    };
}
- (Person *(^)())run
{
    return ^{
        NSLog(@"run---");
        return self;
    };
}
@end
