//
//  Hero.m
//  TableView1
//
//  Created by MS on 15-5-3.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "Hero.h"

@implementation Hero

+ (instancetype)heroWithDict:(NSDictionary *)dict
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
