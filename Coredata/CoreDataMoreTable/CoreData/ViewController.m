//
//  ViewController.m
//  CoreData
//
//  Created by Archy on 15/6/11.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"
#import "Employee.h"
#import "Entity.h"
@interface ViewController ()
{
    NSManagedObjectContext *_companyContext;
    NSManagedObjectContext *_statusContext;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _companyContext = [self setupContextWithModelName:@"Company"];
    _statusContext = [self setupContextWithModelName:@"Weibo"];
    
}

- (NSManagedObjectContext *)setupContextWithModelName:(NSString *)modelName
{
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
    
//    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];

    NSURL *url = [[NSBundle mainBundle] URLForResource:modelName withExtension:@"momd"];
    
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
    
    NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *sqliteName = [NSString stringWithFormat:@"%@.sqlite",modelName];
    
    NSString *sqlitePath = [doc stringByAppendingPathComponent:sqliteName];
    
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:sqlitePath] options:nil error:nil];
    
    context.persistentStoreCoordinator = store;
    
    return context;
}

- (void)addEmployee
{
    for (int i = 0; i < 15 ; i++) {
        Employee *emp = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:_companyContext];
        emp.name = [NSString stringWithFormat:@"ice%d",i];
        emp.height = @(1.80 + 0.01*i);
        emp.birthday = [NSDate date];
    }
    
    NSError *error = nil;
    [_companyContext save:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    
    Entity *status = [NSEntityDescription insertNewObjectForEntityForName:@"Entity" inManagedObjectContext:_statusContext];
    
    status.text = @"Graduation";
    status.createDate = [NSDate date];
    
    [_statusContext save:nil];
}
- (void)vagueSelectEmployee
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    
    NSSortDescriptor *heightSort = [NSSortDescriptor sortDescriptorWithKey:@"height" ascending:NO];
    request.sortDescriptors = @[heightSort];
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name like %@",@"*ce*"];
    request.predicate = pre;
    
    NSError *error = nil;
    NSArray *emps = [_companyContext executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"error");
    }
    
    for (Employee *emp in emps) {
        
        NSLog(@"名字 %@ 身高 %@ 生日 %@",emp.name,emp.height,emp.birthday);
    }
}

- (void)pageSelectEmployee
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    
    NSSortDescriptor *heightSort = [NSSortDescriptor sortDescriptorWithKey:@"height" ascending:NO];
    request.sortDescriptors = @[heightSort];
    
    request.fetchOffset = 0;
    request.fetchLimit = 5;
    NSError *error = nil;
    
    NSArray *emps = [_companyContext executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"error");
    }
    
    for (Employee *emp in emps) {
        
        NSLog(@"名字 %@ 身高 %@ 生日 %@",emp.name,emp.height,emp.birthday);
    }
}
- (void)updateEmployee
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name = %@",@"ice5"];
    
    request.predicate = pre;
    
    NSArray *emps = [_companyContext executeFetchRequest:request error:nil];
    
    for (Employee *emp in emps) {
        emp.height = @2.0;
    }
    [_companyContext save:nil];
}
- (void)deleteEmployee
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name = %@",@"ice6"];
    
    request.predicate = pre;
    
    NSArray *emps = [_companyContext executeFetchRequest:request error:nil];
    
    for (Employee *emp in emps) {
        [_companyContext delete:emp];
    }
    
    [_companyContext save:nil];
}
@end
