//
//  ViewController.m
//  M(LG)JRefresh
//
//  Created by Archy on 15/6/15.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"
#import "MJRefresh.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataSource;
}
@end

@implementation ViewController
-(void)prepareDataSource
{
    _dataSource = [[NSMutableArray alloc]init];
    for (int i = 0; i<5; i++) {
        NSString * string = [NSString stringWithFormat:@"第 %d 条假数据",i+1];
        [_dataSource addObject:string];
    }
}
- (void)prepareTableView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    __weak typeof(self) weakSelf = self;
    [_tableView addLegendHeaderWithRefreshingBlock:^{
        [weakSelf downloadData];
    }];
    
    [_tableView.header beginRefreshing];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [_dataSource objectAtIndex:indexPath.row];
    return cell;
    
}
-(void)downloadData
{
    static int n = 1;
    NSString * string = [NSString stringWithFormat:@"下拉刷新的第 %d  条数据",n++];
    [_dataSource insertObject:string atIndex:0];
    
    //刷新完成后,应该让刷新视图调用下面的方法,来结束刷新,收起刷新提示条
    
    [_tableView reloadData];
    
    [_tableView.header endRefreshing];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self prepareDataSource];
    [self prepareTableView];
}


@end
