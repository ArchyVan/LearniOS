//
//  VAStatus.h
//  TableView3
//
//  Created by MS on 15-5-5.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VAStatus : NSObject

@property (nonatomic,copy)NSString * text;
@property (nonatomic,copy)NSString * icon;
@property (nonatomic,copy)NSString * name;
@property (nonatomic,copy)NSString * picture;
@property (nonatomic,assign)BOOL vip;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)statusWithDict:(NSDictionary *)dict;



@end
