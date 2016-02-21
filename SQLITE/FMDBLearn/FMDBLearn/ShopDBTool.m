//
//  ShopDBTool.m
//  FMDBLearn
//
//  Created by Archy on 15/6/10.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ShopDBTool.h"
#import "fmdb/FMDB.h"
#import "ShopModel.h"

@implementation ShopDBTool

static FMDatabase *_db;

+ (void)initialize
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"shops.sqlite"];
    _db = [FMDatabase databaseWithPath:path];
    
    [_db open];
    
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_shop (id integer PRIMARY KEY, name text NOT NULL, price real);"];
}
+ (void)addShop:(ShopModel *)shop
{
    [_db executeUpdateWithFormat:@"INSERT INTO t_shop(name, price) VALUES (%@, %f);", shop.name, shop.price];
}
+ (NSArray *)fetchShops
{
    FMResultSet *set = [_db executeQuery:@"SELECT FROM t_shop"];
    NSMutableArray *shops = [NSMutableArray array];
    while (set.next) {
        ShopModel *model = [[ShopModel alloc] init];
        model.name = [set stringForColumn:@"name"];
        model.price = [set doubleForColumn:@"price"];
        [shops addObject:model];
    }
    return shops;
}
@end
