//
//  ViewController.m
//  SystemRefresh
//
//  Created by Archy on 15/6/15.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataSource;
    UIRefreshControl *_refreshControl;
}

@end

@implementation ViewController

- (void)prepareDataSource
{
    _dataSource = [NSMutableArray array];
    
    for (int i = 0; i < 5; i++) {
        NSString *string = [NSString stringWithFormat:@"Number %d",i + 1];
        
        [_dataSource addObject:string];
    }
}
- (void)prepareTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    _refreshControl = [[UIRefreshControl alloc] init];
    
    _refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refresh"];
    
    _refreshControl.tintColor = [UIColor grayColor];
    
    [_refreshControl addTarget:self action:@selector(downloadData) forControlEvents:UIControlEventValueChanged];
    
    [_tableView addSubview:_refreshControl];
    
}
- (void)downloadData
{
    static int n = 1;
    NSString *string = [NSString stringWithFormat:@"Refresh Number %d",n++];
    
    [_dataSource insertObject:string atIndex:0];
    
    [_tableView performSelector:@selector(reloadData) withObject:nil afterDelay:1];
    
    [_refreshControl endRefreshing];
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [_dataSource objectAtIndex:indexPath.row];
    return cell;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self prepareDataSource];
    [self prepareTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
