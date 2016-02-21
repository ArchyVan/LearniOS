//
//  VAContactsViewController.m
//  私人通讯录
//
//  Created by MS on 15-5-11.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "VAContactsViewController.h"
#import "VAAddViewController.h"
#import "VAEditViewController.h"
#import "VAContact.h"
#import "VAContactCell.h"

@interface VAContactsViewController ()<UIActionSheetDelegate,VAAddViewControllerDelegate,VAEditViewControllerDelegate>
- (IBAction)logoutClick:(id)sender;
@property (nonatomic, strong)NSMutableArray *contacts;
@end

@implementation VAContactsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
-(NSMutableArray *)contacts
{
    if (_contacts == nil) {
        _contacts = [NSMutableArray array];
    }
    return  _contacts;
}

#pragma mark - Table view data source

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.contacts removeObjectAtIndex:indexPath.row];
    
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contacts.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VAContactCell *cell = [VAContactCell cellWithTableView:tableView];
    
    cell.contact = self.contacts[indexPath.row];
    
    return cell;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id vc = segue.destinationViewController;
    
    if ([vc isKindOfClass:[VAAddViewController class]]) {
        VAAddViewController *addVc = vc;
        addVc.delegate = self;
    } else if ([vc isKindOfClass:[VAEditViewController class]]){
        VAEditViewController *editVc = vc;
        
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        editVc.contact = self.contacts[path.row];
        editVc.delegate = self;
    }
}
- (IBAction)logoutClick:(id)sender {
    
    UIActionSheet * sheet = [[UIActionSheet alloc]initWithTitle:@"确认注销吗?" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确认" otherButtonTitles:nil, nil];
    
    [sheet showInView:self.view];
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex!=0) return;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addViewController:(VAAddViewController *)addVc didAddContact:(VAContact *)contact
{
    [self.contacts addObject:contact];
    
    [self.tableView reloadData];
}
- (void)editViewController:(VAEditViewController *)editVc didSaveContact:(VAContact *)contact
{
    [self.tableView reloadData];
}
@end
