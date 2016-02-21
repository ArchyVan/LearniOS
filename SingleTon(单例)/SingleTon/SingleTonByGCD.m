//
//  SingleTonByGCD.m
//  SingleTon
//
//  Created by Archy on 15/6/2.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "SingleTonByGCD.h"

@implementation SingleTonByGCD
static id _instance;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+(instancetype)sharedSingleTon
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}
/**
 *  当第一次使用这个类的时候才会调用
 */
+(void)initialize{}
@end
