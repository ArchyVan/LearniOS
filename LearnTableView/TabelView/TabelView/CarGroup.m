//
//  CarGroup.m
//  TabelView
//
//  Created by MS on 15-5-3.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "CarGroup.h"
#import "Car.h"
@implementation CarGroup
+(instancetype)groupWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.title = dict[@"title"];
        
        NSArray * dictArray = dict[@"cars"];
        
        NSMutableArray *carArray = [NSMutableArray array];
        
        for (NSDictionary * dict in dictArray) {
            Car *car = [Car carWithDict:dict];
            
            [carArray addObject:car];
            
        }
        self.cars = carArray;
    }
    return self;
}
@end
