//
//  VAFlag.m
//  PickerView1
//
//  Created by MS on 15-5-9.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "VAFlag.h"

@implementation VAFlag

+ (instancetype)flagWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end
