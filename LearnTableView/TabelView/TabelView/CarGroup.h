//
//  CarGroup.h
//  TabelView
//
//  Created by MS on 15-5-3.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarGroup : NSObject

@property (nonatomic,copy)NSString * title;

@property (nonatomic,strong)NSArray * cars;

+ (instancetype)groupWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
