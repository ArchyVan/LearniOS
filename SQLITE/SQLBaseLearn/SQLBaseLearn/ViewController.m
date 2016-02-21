//
//  ViewController.m
//  SQLBaseLearn
//
//  Created by Archy on 15/6/10.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"
#import "ShopModel.h"
#import <sqlite3.h>

@interface ViewController ()

@property (nonatomic, assign) sqlite3 *db;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)setupDB
{
    NSString *fileName = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"shop.sqlite"];
    
    int status = sqlite3_open(fileName.UTF8String, &_db);
    if (status == SQLITE_OK) {
        NSLog(@"打开数据库成功");
        
        const char *sql = "CREATE TABLE IF NOT EXISTS t_shop (id integer PRIMARY KEY, name text NOT NULL, price real);";
        
        char *errmsg = NULL;
        
        sqlite3_exec(self.db, sql, NULL, NULL, &errmsg);
        
        if (errmsg) {
            NSLog(@"创表失败--%s",errmsg);
        }
    } else {
    
        NSLog(@"打开数据库失败");
    }
    
    
}
- (void)selectDB
{
    const char *sql = "SELECT name,price FROM t_shop;";
    
    
//    NSString *sql = [NSString stringWithFormat:@"SELECT name,price FROM t_shop WHERE name LIKE '%%%@%%' OR  price LIKE '%%%@%%' ;", searchText, searchText];

    sqlite3_stmt *stmt = NULL;
    
    int status = sqlite3_prepare_v2(self.db, sql, -1, &stmt, NULL);
    
    if (status == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            const char *name = (const char*)sqlite3_column_text(stmt, 0);
            const char *price = (const char*)sqlite3_column_text(stmt, 1);
            
            ShopModel *model = [[ShopModel alloc] init];
            model.name = [NSString stringWithUTF8String:name];
            model.price = [NSString stringWithUTF8String:price];
        }
    }
}

- (void)insertDB
{
    NSString *sql = @"INSERT INTO t_shop(name, price) VALUES ('Archy', 200);";
    
    sqlite3_exec(self.db, sql.UTF8String, NULL, NULL, NULL);

}

@end















