//
//  ViewController.m
//  TableView1
//
//  Created by MS on 15-5-3.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"
#import "Hero.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property (nonatomic,strong)NSArray *heros;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(NSArray *)heros
{
    if (_heros == nil) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"heros.plist" ofType:nil];
        
        
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray * heroArray = [NSMutableArray array];
        
        for (NSDictionary *dict in dictArray) {
            Hero *hero = [Hero heroWithDict:dict];
            [heroArray addObject:hero];
        }
        _heros = heroArray;
    }
    return _heros;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.heros.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID =@"hero";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    Hero *hero =self.heros[indexPath.row];
    
    cell.textLabel.text = hero.name;
    cell.detailTextLabel.text = hero.intro;
    
    cell.imageView.image = [UIImage imageNamed:hero.icon];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Hero *hero = self.heros[indexPath.row];

    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Hero" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Commit", nil];
    
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    [alert textFieldAtIndex:0].text = hero.name;
    
    [alert show];
    
    alert.tag = indexPath.row;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        return;
    }
    NSString * name = [alertView textFieldAtIndex:0].text;
    
    int row = alertView.tag;
    Hero *hero = self.heros[row];
    hero.name = name;
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationBottom];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
@end
