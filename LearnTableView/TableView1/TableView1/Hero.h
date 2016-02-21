//
//  Hero.h
//  TableView1
//
//  Created by MS on 15-5-3.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hero : NSObject

@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * icon;
@property (nonatomic,copy) NSString * intro;

+ (instancetype)heroWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
