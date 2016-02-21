//
//  ViewController.m
//  CustomRefresh
//
//  Created by Archy on 15/6/15.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;  //显示数据
    NSMutableArray * _dataSource; //数据源
    BOOL _isRefresh; //用来判断是否要刷新的标记
}
@end

@implementation ViewController

-(void)prepareTableView
{
    self.title = @"下拉刷新";
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, 320, 416) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    //在tableView上去加一个视图
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, -200, 320, 200)];
    view.backgroundColor = [UIColor cyanColor];
    [_tableView addSubview:view];
    //创建一个label用来显示下拉刷新的字
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 320, 100)];
    label.text = @"下拉刷新";
    label.tag = 1000;
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    
    
}
-(void)prepareDataSource
{
    _dataSource = [[NSMutableArray alloc]init];
    for (int i = 0; i<5; i++) {
        NSString * string = [NSString stringWithFormat:@"第 %d 条原始数据",i+1];
        [_dataSource addObject:string];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [_dataSource objectAtIndex:indexPath.row];
    return cell;
}


//实现tableView的父类中的正在滚动这个方法,来实现下拉刷新的效果
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%.2f",scrollView.contentOffset.y);
    //判断是否刷新的这个标记变量,如果正在刷新的话,就不能再执行下面的的刷新动作,直接返回
    if (_isRefresh) {
        return;
    }
    //如果满足条件去刷新
    //因为一会不管刷新不刷新,lable上的字,都要根据条件发生变化
    UILabel * label = (UILabel *)[scrollView viewWithTag:1000];
    if (scrollView.contentOffset.y <= -100) {
        //请求数据
        _isRefresh = YES;
        label.text = @"松开即可刷新数据";
        
        //开始请求数据,这里先用假数据,真正实现时,这里可以发生网络请求
        [self performSelector:@selector(downloadData) withObject:nil afterDelay:1];
        
    }
    else
    {
        label.text = @"下拉刷新";
    }
    
}
//加载数据的方法
-(void)downloadData
{
    static int n = 1;
    NSString * string = [NSString stringWithFormat:@"下拉刷新的第 %d 条数据",n++];
    //因为要下拉刷新,刷新的内容应该显示到最上面,所以数据要插入到数据源的开始
    [_dataSource insertObject:string atIndex:0];
    
    //数据源更新后,还需要去更新tableView
    [_tableView reloadData];
    
    //最后,刷新完毕后,将刷新标志置为no
    _isRefresh = NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self prepareDataSource];
    [self prepareTableView];
}

@end
