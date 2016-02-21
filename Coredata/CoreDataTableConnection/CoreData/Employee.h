//
//  Employee.h
//  CoreData
//
//  Created by Archy on 15/6/11.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Department;

@interface Employee : NSManagedObject

@property (nonatomic, retain) NSDate * birthday;
@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Department *depart;

@end
