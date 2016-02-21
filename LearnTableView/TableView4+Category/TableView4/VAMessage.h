//
//  VAMessage.h
//  TableView4
//
//  Created by MS on 15-5-5.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    VAMessageTypeMe = 0,
    VAMessageTypeOther
} VAMessageType;

@interface VAMessage : NSObject

@property (nonatomic,copy)NSString * text;

@property (nonatomic,copy)NSString * time;

@property (nonatomic, assign) VAMessageType type;

@property (nonatomic, assign) BOOL hideTime;


+ (instancetype)messageWithDict:(NSDictionary *)dict;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
