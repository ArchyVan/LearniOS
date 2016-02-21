//
//  VAFriend.h
//  TableView5
//
//  Created by MS on 15-5-6.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VAFriend : NSObject
@property (nonatomic,copy)NSString * name;
@property (nonatomic,copy)NSString * icon;
@property (nonatomic,copy)NSString * intro;
@property (nonatomic, assign, getter = isVip)BOOL vip;

+ (instancetype)friendWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
