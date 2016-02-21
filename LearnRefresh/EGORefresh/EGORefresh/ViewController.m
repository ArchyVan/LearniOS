//
//  ViewController.m
//  EGORefresh
//
//  Created by Archy on 15/6/15.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"
#import "EGORefreshTableHeaderView.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataSource;
    EGORefreshTableHeaderView *_refreshView;
    BOOL _isRefreshing;
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
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    _refreshView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, -200, _tableView.frame.size.width, 200)];
    
    _refreshView.delegate = self;
    [_tableView addSubview:_refreshView];
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

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view
{
    return _isRefreshing;
}
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view
{
    if (!_isRefreshing) {
        _isRefreshing = YES;
        
        [self performSelector:@selector(downloadData) withObject:nil afterDelay:1];
    }
}
-(void)downloadData
{
    static int n = 1;
    NSString * string = [NSString stringWithFormat:@"下拉刷新的第 %d  条数据",n++];
    [_dataSource insertObject:string atIndex:0];
    
    //刷新完成后,应该让刷新视图调用下面的方法,来结束刷新,收起刷新提示条
    [_refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:_tableView];
    //改变标记状态
    _isRefreshing = NO;
    NSLog(@"aaaa");
    
    [_tableView reloadData];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshView egoRefreshScrollViewDidScroll:scrollView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshView egoRefreshScrollViewDidEndDragging:scrollView];
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
