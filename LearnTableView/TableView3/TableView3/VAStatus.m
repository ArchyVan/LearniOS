//
//  VAStatus.m
//  TableView3
//
//  Created by MS on 15-5-5.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "VAStatus.h"

@implementation VAStatus

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)statusWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
@end
