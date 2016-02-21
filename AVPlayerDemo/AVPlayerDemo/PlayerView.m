//
//  PlayerView.m
//  AVPlayerDemo
//
//  Created by pk on 15/6/17.
//  Copyright © 2015年 pk. All rights reserved.
//

#import "PlayerView.h"

@implementation PlayerView

//view.layer   CALayer
+ (nonnull Class)layerClass{
    return [AVPlayerLayer class];
}

- (void)setPlayer:(AVPlayer *)player{
    AVPlayerLayer* layer = (AVPlayerLayer*)self.layer;
    [layer setPlayer:player];
}




@end
