//
//  ViewController.m
//  02.UIDynamic演练
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "ViewController.h"
#import "DemoViewController.h"

@interface ViewController ()
{
    // 功能名称的数组
    NSArray *_functions;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _functions = @[@"吸附行为", @"推动行为", @"刚性附加行为", @"弹性附加行为", @"碰撞检测"];
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _functions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 使用Storyboard建立的UITabeViewController，其中的Cell是已经注册过的
    static NSString *ID = @"Cell";
    // 永远都会找到一个单元格，如果缓冲池中没有，会自动新建
    /**
     dequeueReusableCellWithIdentifier 直接查询可重用单元格
     dequeueReusableCellWithIdentifier:forIndexPath: 查询“注册的”可重用单元格，此方法中indexPath本身没有用处
     
        * 强制判断是否注册了单元格
     
     如果已经注册过单元格，以上两个方法等效。
     
     如果在StoryBoard中指定了单元格的可重用标示符，单元格的优化将有系统接管，不再需要判断cell == nil
     */
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
//    if (cell == nil) {
//        NSLog(@"come here");
//        
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//    }
    
    cell.textLabel.text = _functions[indexPath.row];
    
    return cell;
}

#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DemoViewController *controller = [[DemoViewController alloc] init];
    
    // 指定标题
    controller.title = _functions[indexPath.row];
    controller.function = indexPath.row;
    
    [self.navigationController pushViewController:controller animated:YES];
}

@end
