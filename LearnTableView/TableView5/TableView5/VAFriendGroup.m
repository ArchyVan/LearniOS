//
//  VAFriendGroup.m
//  TableView5
//
//  Created by MS on 15-5-6.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "VAFriendGroup.h"
#import "VAFriend.h"
@implementation VAFriendGroup
+ (instancetype)groupWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        NSMutableArray * friendArray = [NSMutableArray array];
        for (NSDictionary * dict in self.friends) {
            VAFriend * friend = [VAFriend friendWithDict:dict];
            [friendArray addObject:friend];
        }
        self.friends = friendArray;
    }
    return self;
}
@end
