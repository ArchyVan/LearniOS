//
//  VAViewController.m
//  TableView5
//
//  Created by MS on 15-5-6.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "VAViewController.h"
#import "VAFriendGroup.h"
#import "VAFriend.h"
#import "VAFriendCell.h"
#import "VAHeaderView.h"
@interface VAViewController ()<VAHeaderViewDelegate>
@property (nonatomic, strong)NSArray *groups;

@end

@implementation VAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.rowHeight = 50;
    
    self.tableView.sectionHeaderHeight = 44;
    
}
-(NSArray *)groups
{
    if (_groups == nil) {
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"friends.plist" ofType:nil]];
        
        NSMutableArray *groupArray = [NSMutableArray array];
        
        for (NSDictionary *dict in dictArray) {
            VAFriendGroup *group = [VAFriendGroup groupWithDict:dict];
            [groupArray addObject:group];
        }
        _groups = groupArray;
    }
    return _groups;
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
#pragma mark - Data

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    VAFriendGroup *group = self.groups[section];
    
    return (group.isOpened ? group.friends.count: 0);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VAFriendCell * cell = [VAFriendCell cellWithTableView:tableView];
    
    VAFriendGroup * group = self.groups[indexPath.section];
    
    cell.friendData = group.friends[indexPath.row];
    
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    VAHeaderView * header = [VAHeaderView headerViewWithTableView:tableView];
    
    header.delegate = self;
    
    header.group = self.groups[section];
    
    return header;
}

- (void)headerViewDidClickedNameView:(VAHeaderView *)headerView
{
    [self.tableView reloadData];
}
@end
