//
//  PlayerView.h
//  AVPlayerDemo
//
//  Created by pk on 15/6/17.
//  Copyright © 2015年 pk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface PlayerView : UIView

+ (nonnull Class)layerClass;

//关联屏幕和播放器
- (void)setPlayer:(AVPlayer*)player;


@end
