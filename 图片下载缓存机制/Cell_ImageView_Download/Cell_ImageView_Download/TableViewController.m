//
//  TableViewController.m
//  Cell_ImageView_Download
//
//  Created by Archy on 15/6/4.
//  Copyright (c) 2015年 Van. All rights reserved.
//
#define kAppImageFile(url) [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[url lastPathComponent]]

#import "TestApp.h"
#import "TableViewController.h"

@interface TableViewController ()

@property (nonatomic, strong) NSMutableArray *apps;
@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, strong) NSMutableDictionary *operations;
@property (nonatomic, strong) NSMutableDictionary *images;

@end

@implementation TableViewController

- (NSMutableArray *)apps
{
    if (!_apps) {
        NSString *file = [[NSBundle mainBundle]pathForResource:@"apps" ofType:@"plist"];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:file];
        
        NSMutableArray *appArray = [NSMutableArray array];
        
        for (NSDictionary *dict  in dictArray) {
            TestApp *app = [TestApp appWithDictionary:dict];
            
            [appArray addObject:app];
        }
        self.apps = appArray;
    }
    return _apps;
}

- (NSOperationQueue *)queue
{
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}
- (NSMutableDictionary *)images
{
    if (!_images) {
        _images = [NSMutableDictionary dictionary];
    }
    return _images;
}
- (NSMutableDictionary *)operations
{
    if (!_operations) {
        _operations = [NSMutableDictionary dictionary];
    }
    return _operations;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    [self.queue cancelAllOperations];
    [self.operations removeAllObjects];
    [self.images removeAllObjects];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.apps.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIde = @"app";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIde];
    }
    TestApp *app = self.apps[indexPath.row];
    cell.textLabel.text = app.name;
    cell.detailTextLabel.text = app.download;
    
    UIImage *image = self.images[app.icon];
    if (image) {
        cell.imageView.image = image;
    } else {
        NSString *file = kAppImageFile(app.icon);
        
        NSData *data = [NSData dataWithContentsOfFile:file];
        
        if (data) {
            cell.imageView.image = [UIImage imageWithData:data];
        } else {
            cell.imageView.image = [UIImage imageNamed:@"placeholder"];
            
            [self download:app.icon indexPath:indexPath];
        }
    }
    
    return cell;
}

- (void)download:(NSString *)imageUrl indexPath:(NSIndexPath *)indexPath
{
    NSBlockOperation *operation = self.operations[imageUrl];
    
    if (operation) return;
    
    __weak typeof(self) mySelf = self;
    operation = [NSBlockOperation blockOperationWithBlock:^{
        NSURL *url = [NSURL URLWithString:imageUrl];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            if (image) {
                mySelf.images[imageUrl] = image;
                
                NSData *data = UIImagePNGRepresentation(image);
                
                [data writeToFile:kAppImageFile(imageUrl) atomically:YES];
                
                [mySelf.operations removeObjectForKey:imageUrl];
                
                [mySelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
    }];
    [self.queue addOperation:operation];
    
    self.operations[imageUrl] = operation;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.queue setSuspended:NO];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.queue setSuspended:YES];
}
@end
