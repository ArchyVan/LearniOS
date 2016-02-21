//
//  VAViewController.m
//  TableView3
//
//  Created by MS on 15-5-5.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "VAViewController.h"
#import "VAStatus.h"
#import "VAStatusCell.h"
#import "VAStatusFrame.h"

@interface VAViewController ()

@property (nonatomic, strong)NSArray * statusFrames;

@end

@implementation VAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(NSArray *)statusFrames
{
    if (_statusFrames == nil) {
        NSString * path = [[NSBundle mainBundle]pathForResource:@"statuses.plist" ofType:nil];
        
        NSArray * dictArray = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray * statusFrameArray = [NSMutableArray array];
        
        for (NSDictionary * dict in dictArray) {
            
            VAStatus *status = [VAStatus statusWithDict:dict];
            
            VAStatusFrame * statusFrame = [[VAStatusFrame alloc]init];
            
            statusFrame.status = status;
            
            [statusFrameArray addObject:statusFrame];
        }
        _statusFrames = statusFrameArray;
    }
    return _statusFrames;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusFrames.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VAStatusCell *cell = [VAStatusCell cellWithTableView:tableView];
    
    cell.statusFrame = self.statusFrames[indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VAStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    return statusFrame.cellHeight;
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}




@end
