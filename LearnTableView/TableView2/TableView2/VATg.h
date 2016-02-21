//
//  VATg.h
//  TableView2
//
//  Created by MS on 15-5-4.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VATg : NSObject

@property (nonatomic,copy)NSString * title;
@property (nonatomic,copy)NSString * price;
@property (nonatomic,copy)NSString * icon;
@property (nonatomic,copy)NSString * buyCount;

+ (instancetype)tgWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;



@end
