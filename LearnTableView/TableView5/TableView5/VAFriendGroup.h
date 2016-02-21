//
//  VAFriendGroup.h
//  TableView5
//
//  Created by MS on 15-5-6.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VAFriendGroup : NSObject
@property (nonatomic,copy)NSString * name;

@property (nonatomic,strong)NSArray * friends;

@property (nonatomic,assign)int online;

@property (nonatomic, assign, getter = isOpened) BOOL opened;

+ (instancetype)groupWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
