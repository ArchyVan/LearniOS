//
//  Boss.h
//  CoreData
//
//  Created by Life's a struggle on 15/6/27.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Boss : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * attribute1;
@property (nonatomic, retain) NSNumber * attribute2;
@property (nonatomic, retain) NSNumber * attribute3;

@end
