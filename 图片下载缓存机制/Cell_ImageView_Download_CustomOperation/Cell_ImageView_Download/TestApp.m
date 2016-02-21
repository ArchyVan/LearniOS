//
//  TestApp.m
//  Cell_ImageView_Download
//
//  Created by Archy on 15/6/4.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "TestApp.h"

@implementation TestApp

+ (id)appWithDictionary:(NSDictionary *)dictionary
{
    return [[self alloc]initWithDictionary:dictionary];
}
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}
@end
