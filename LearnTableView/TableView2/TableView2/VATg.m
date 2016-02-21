//
//  VATg.m
//  TableView2
//
//  Created by MS on 15-5-4.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "VATg.h"

@implementation VATg

+ (instancetype)tgWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end
