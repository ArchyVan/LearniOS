//
//  VAViewController.m
//  TableView2
//
//  Created by MS on 15-5-4.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "VAViewController.h"
#import "VATg.h"
#import "VATgCell.h"
#import "VAFooterView.h"
@interface VAViewController ()<UITableViewDataSource,UITableViewDelegate,VAFooterViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *tgs;

@end

@implementation VAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.rowHeight = 80;
    
    VAFooterView *footer =[VAFooterView footerView];
    footer.delegate = self;
    
    self.tableView.tableFooterView = footer;
    
}
- (void)footerViewDidClickedLoadButton:(VAFooterView *)vaFooterView
{
    VATg * tg = [[VATg alloc]init];
    
    tg.icon = @"ad_01";
    tg.title = @"新增加的团购数据..";
    tg.price = @"100";
    tg.buyCount = @"0";
    [self.tgs addObject:tg];
    
    [self.tableView reloadData];
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (NSMutableArray *)tgs
{
    if (_tgs == nil) {
        
        NSString *path = [[NSBundle mainBundle]pathForResource:@"tgs.plist" ofType:nil];
        
        NSArray * dictArray = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray * tgArray = [NSMutableArray array];
        
        for (NSDictionary *dict in dictArray) {
            VATg *tg = [VATg tgWithDict:dict];
            
            [tgArray addObject:tg];
        }
        _tgs = tgArray;
    }
    return _tgs;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tgs.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VATgCell * cell = [VATgCell cellWithTableView:tableView];
    
    cell.tg = self.tgs[indexPath.row];
    return cell;
}
@end
