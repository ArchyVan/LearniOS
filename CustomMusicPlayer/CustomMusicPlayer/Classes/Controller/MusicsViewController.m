//
//  MusicsViewController.m
//  CustomMusicPlayer
//
//  Created by Archy on 15/6/15.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "MusicsViewController.h"
#import "PlayingViewController.h"
#import "MJExtension.h"
#import "Music.h"
#import "MusicTool.h"
#import "MusicCell.h"

@interface MusicsViewController ()

@property (nonatomic, strong) PlayingViewController *playingVC;

@end

@implementation MusicsViewController
- (PlayingViewController *)playingVC
{
    if (!_playingVC)
    {
        self.playingVC = [[PlayingViewController alloc] init];
    }
    return _playingVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [MusicTool musics].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MusicCell *cell = [MusicCell cellWithTableView:tableView];
    
    cell.music = [MusicTool musics][indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [MusicTool setPlayingMusic:[MusicTool musics][indexPath.row]];
    
    [self.playingVC show];
}







@end
