//
//  ViewController.m
//  CoreData
//
//  Created by Archy on 15/6/11.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"
#import "Employee.h"

@interface ViewController ()
{
    //管理对象上下文
    NSManagedObjectContext *_context;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
//初始化操作(写入缓存/文件夹)
- (void)setupEmployee
{
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
    
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *sqlitePath = [doc stringByAppendingPathComponent:@"company.sqlite"];
    
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:sqlitePath] options:nil error:nil];
    
    context.persistentStoreCoordinator = store;
    
    _context = context;
}
//增加操作
- (void)addEmployee
{
    for (int i = 0; i < 15 ; i++) {
        Employee *emp = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:_context];
        emp.name = [NSString stringWithFormat:@"ice%d",i];
        emp.height = @(1.80 + 0.01*i);
        emp.birthday = [NSDate date];
    }
    
    NSError *error = nil;
    [_context save:&error];
    if (error) {
        NSLog(@"%@",error);
    }
}
//模糊查询操作
- (void)vagueSelectEmployee
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    
    NSSortDescriptor *heightSort = [NSSortDescriptor sortDescriptorWithKey:@"height" ascending:NO];
    request.sortDescriptors = @[heightSort];
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name like %@",@"*ce*"];
    request.predicate = pre;
    
    NSError *error = nil;
    NSArray *emps = [_context executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"error");
    }
    
    for (Employee *emp in emps) {
        
        NSLog(@"名字 %@ 身高 %@ 生日 %@",emp.name,emp.height,emp.birthday);
    }
}
//按页查询
- (void)pageSelectEmployee
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    
    NSSortDescriptor *heightSort = [NSSortDescriptor sortDescriptorWithKey:@"height" ascending:NO];
    request.sortDescriptors = @[heightSort];
    
    request.fetchOffset = 0;
    request.fetchLimit = 5;
    NSError *error = nil;
    
    NSArray *emps = [_context executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"error");
    }
    
    for (Employee *emp in emps) {
        
        NSLog(@"名字 %@ 身高 %@ 生日 %@",emp.name,emp.height,emp.birthday);
    }
}
//更新数据
- (void)updateEmployee
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name = %@",@"ice5"];
    
    request.predicate = pre;
    
    NSArray *emps = [_context executeFetchRequest:request error:nil];
    
    for (Employee *emp in emps) {
        emp.height = @2.0;
    }
    [_context save:nil];
}
//删除数据
- (void)deleteEmployee
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name = %@",@"ice6"];
    
    request.predicate = pre;
    
    NSArray *emps = [_context executeFetchRequest:request error:nil];
    
    for (Employee *emp in emps) {
        [_context delete:emp];
    }
    
    [_context save:nil];
}
@end
