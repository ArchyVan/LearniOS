//
//  VAApp.h
//  TableView6
//
//  Created by MS on 15-5-8.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VAApp : NSObject

@property (copy, nonatomic) NSString *icon;

@property (copy, nonatomic) NSString *name;

@property (copy, nonatomic) NSString *size;

@property (copy, nonatomic) NSString *download;

@property (nonatomic, assign, getter = isDownloaded) BOOL downloaded;

+ (instancetype)appWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
