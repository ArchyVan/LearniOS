//
//  MusicTool.h
//  CustomMusicPlayer
//
//  Created by Archy on 15/6/15.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Music;

@interface MusicTool : NSObject

+ (NSArray *)musics;

+ (Music *)playingMusic;

+ (void)setPlayingMusic:(Music *)playingMusic;

+ (Music *)nextMusic;

+ (Music *)previousMusic;

@end
