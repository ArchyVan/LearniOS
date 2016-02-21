//
//  ViewController.m
//  CoreData
//
//  Created by Archy on 15/6/11.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "ViewController.h"
#import "Employee.h"
#import "Department.h"

@interface ViewController ()
{
    NSManagedObjectContext *_context;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

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

- (void)addEmployee
{
    Department *iosDepart = [NSEntityDescription insertNewObjectForEntityForName:@"Department" inManagedObjectContext:_context];
    
    iosDepart.name = @"ios";
    iosDepart.departNumber = @"0001";
    iosDepart.createDate = [NSDate date];
    
    Department *androidDepart = [NSEntityDescription insertNewObjectForEntityForName:@"Department" inManagedObjectContext:_context];
    androidDepart.name = @"android";
    androidDepart.departNumber = @"0002";
    androidDepart.createDate = [NSDate date];
    
    Employee *zhangsan = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:_context];
    zhangsan.name = @"zhangsan";
    zhangsan.height = @(1.80);
    zhangsan.birthday = [NSDate date];
    zhangsan.depart = iosDepart;
    
    Employee *lisi = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:_context];
    lisi.name = @"lisi";
    lisi.height = @(1.70);
    lisi.birthday = [NSDate date];
    lisi.depart = androidDepart;
    
    NSError *error = nil;
    [_context save:&error];
    if (error) {
        NSLog(@"%@",error);
    }
}
- (void)vagueSelectEmployee
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"depart.name = %@",@"android"];
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
@end
