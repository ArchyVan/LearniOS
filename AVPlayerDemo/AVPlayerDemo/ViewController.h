//
//  ViewController.h
//  AVPlayerDemo
//
//  Created by pk on 15/6/17.
//  Copyright (c) 2015年 pk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerView.h"

@interface ViewController : UIViewController{
    AVPlayer* _player;
    PlayerView* _playerView;
    UISlider* _proSlider;
}


@end

