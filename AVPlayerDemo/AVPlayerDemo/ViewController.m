//
//  ViewController.m
//  AVPlayerDemo
//
//  Created by pk on 15/6/17.
//  Copyright (c) 2015年 pk. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建屏幕
    _playerView = [[PlayerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 240)];
    [self.view addSubview:_playerView];
    
    //进度条
    _proSlider = [[UISlider alloc] initWithFrame:CGRectMake(50, 270, 220, 20)];
    _proSlider.value = 0;
    [_proSlider addTarget:self action:@selector(changePro) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_proSlider];
    
    //播放暂停按钮
    UIButton* playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    playButton.frame = CGRectMake(110, 300, 100, 20);
    [playButton setTitle:@"play" forState:UIControlStateNormal];
    [playButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [playButton addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playButton];
    
    UIButton* pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    pauseButton.frame = CGRectMake(110, 330, 100, 20);
    [pauseButton setTitle:@"pause" forState:UIControlStateNormal];
    [pauseButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [pauseButton addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pauseButton];
    
    //播放地址
    NSURL* url = [NSURL URLWithString:@""];
    //资源
    AVURLAsset* asset = [AVURLAsset assetWithURL:url];
    //准备播放
    [asset loadValuesAsynchronouslyForKeys:@[@"tracks"] completionHandler:^{
        //播放项
        AVPlayerItem* playerItem = [AVPlayerItem playerItemWithAsset:asset];
        //创建播放器
        _player = [[AVPlayer alloc] initWithPlayerItem:playerItem];
        //关联屏幕和播放器
        [_playerView setPlayer:_player];
        
        //进度
        [_player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
            //进度=当前时间/总时间
            CMTime currentTime = _player.currentItem.currentTime;
            CMTime duration = _player.currentItem.duration;
            float pro = CMTimeGetSeconds(currentTime) / CMTimeGetSeconds(duration);
            [_proSlider setValue:pro animated:YES];
        }];
    }];
}

//改变进度
- (void)changePro{
    //当前时间=总时间 * 进度
    CMTime currentTime = CMTimeMultiplyByFloat64(_player.currentItem.duration, _proSlider.value);
    [_player seekToTime:currentTime];
}

//播放
- (void)play{
    [_player play];
}

//暂停
- (void)pause{
    [_player pause];
}







@end
