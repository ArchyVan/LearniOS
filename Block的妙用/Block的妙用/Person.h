//
//  Person.h
//  Block的妙用
//
//  Created by Archy on 15/6/11.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

- (Person *(^)(NSString *name))study;
- (Person *(^)())run;

@end
