//
//  VACommon+-.h
//  PickerView2
//
//  Created by MS on 15-5-9.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#ifndef PickerView2_VACommon___h
#define PickerView2_VACommon___h

#define kInitH(name) \
- (id)initWithDict:(NSDictionary *)dict; \
+ (id)name##WithDict:(NSDictionary *)dict;

#define kInitM(name) \
+ (id)name##WithDict:(NSDictionary *)dict \
{\
    return [[self alloc] initWithDict:dict]; \
}

#endif
