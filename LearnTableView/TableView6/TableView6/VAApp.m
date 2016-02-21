//
//  VAApp.m
//  TableView6
//
//  Created by MS on 15-5-8.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "VAApp.h"

@implementation VAApp
+ (instancetype)appWithDict:(NSDictionary *)dict
{
    return  [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end
