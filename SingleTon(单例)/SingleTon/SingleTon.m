//
//  SingleTon.m
//  SingleTon
//
//  Created by Archy on 15/6/2.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "SingleTon.h"

@implementation SingleTon
static id _instance;

/**
 *  当类加载到OC运行时环境中（内存），就会调用一次（一个类只会加载1次）
 */
+(void)load
{
    /**
        _instance = [[self alloc] init];
     懒汉式加载（写上这句）
     */
}
/**
 *  饿汉式加载
 */
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    if (_instance == nil) {
        @synchronized(self)
        {
            if (_instance == self) {
                _instance = [super allocWithZone:zone];
            }
        }
    }
    return _instance;
}

+ (instancetype)sharedSingleTon
{
    if (_instance == nil) {
        @synchronized(self)
        {
            if (_instance == nil) {
                _instance = [[super alloc] init];
            }
        }
    }
    return _instance;
}
- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}

/**
 *  MRC环境下
 */
//- (oneway void)release { }
//- (instancetype)retain { return self;}
//- (NSUInteger)retainCount{ return 1;}
//- (id)autorelease{ return self;}



@end
