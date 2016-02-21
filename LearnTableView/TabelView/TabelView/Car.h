//
//  Car.h
//  TabelView
//
//  Created by MS on 15-5-3.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject

@property (nonatomic,copy)NSString * icon;

@property (nonatomic,copy)NSString * name;

+ (instancetype)carWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
