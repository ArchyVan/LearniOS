//
//  VAFriend.m
//  TableView5
//
//  Created by MS on 15-5-6.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "VAFriend.h"

@implementation VAFriend
+ (instancetype)friendWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end
