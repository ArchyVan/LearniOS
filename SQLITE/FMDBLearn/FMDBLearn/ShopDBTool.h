//
//  ShopDBTool.h
//  FMDBLearn
//
//  Created by Archy on 15/6/10.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ShopModel;

@interface ShopDBTool : NSObject

+ (NSArray *)fetchShops;
+ (void)addShop:(ShopModel *)shop;

@end
