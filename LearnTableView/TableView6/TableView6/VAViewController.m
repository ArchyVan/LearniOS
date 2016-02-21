//
//  VAViewController.m
//  TableView6
//
//  Created by MS on 15-5-8.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "VAViewController.h"
#import "VAApp.h"
#import "VAAppCell.h"
@interface VAViewController ()<VAAppCellDelegate>

@property (nonatomic, strong)NSArray *apps;
@end

@implementation VAViewController

-(NSArray *)apps
{
    if (_apps == nil) {
        NSArray * dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"apps_full.plist" ofType:nil]];
        
        NSMutableArray * appArray = [NSMutableArray array];
        for (NSDictionary * dict in dictArray) {
            VAApp * app = [VAApp appWithDict:dict];
            
            [appArray addObject:app];
        }
        _apps = appArray;
    }
    return _apps;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.apps.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VAAppCell *cell = [tableView dequeueReusableCellWithIdentifier:@"app"];
    cell.delegate = self;
    cell.app = self.apps[indexPath.row];
    return cell;
}
-(void)appCellDidClickedDownloadButton:(VAAppCell *)cell
{
    UILabel *label = [[UILabel alloc] init];
    label.text = [NSString stringWithFormat:@"成功下载%@", cell.app.name];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor blackColor];
    label.frame = CGRectMake(0, 0, 150, 25);
    label.center = CGPointMake(160, 240);
    label.alpha = 0.0;
    label.layer.cornerRadius = 5;
    label.clipsToBounds = YES;
    [self.view addSubview:label];
    
    // 2.动画
    [UIView animateWithDuration:0.5 animations:^{
        label.alpha = 0.5;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
            label.alpha = 0.0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
    
}
@end
