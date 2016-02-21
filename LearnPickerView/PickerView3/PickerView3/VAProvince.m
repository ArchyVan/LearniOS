//
//  VAProvince.m
//  PickerView3
//
//  Created by MS on 15-5-9.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "VAProvince.h"

@implementation VAProvince
- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.name = dict[@"name"];
        self.cities = dict[@"cities"];
    }
    return self;
}

kInitM(province)

@end
