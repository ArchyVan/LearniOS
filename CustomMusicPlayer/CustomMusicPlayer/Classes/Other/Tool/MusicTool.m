//
//  MusicTool.m
//  CustomMusicPlayer
//
//  Created by Archy on 15/6/15.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "MusicTool.h"
#import "Music.h"
#import "MJExtension.h"

@implementation MusicTool

static NSArray *_musics;
static Music *_playingMusic;

+ (NSArray *)musics
{
    if (!_musics) {
        _musics = [Music objectArrayWithFilename:@"Musics.plist"];
    }
    return _musics;
}
+ (Music *)playingMusic
{
    return _playingMusic;
}
+ (void)setPlayingMusic:(Music *)playingMusic
{
    if (!playingMusic || ![[self musics]containsObject:playingMusic]) {
        return;
    }
    if (_playingMusic == playingMusic) {
        return;
    }
    
    _playingMusic = playingMusic;
}
+ (Music *)nextMusic
{
    NSInteger nextIndex = 0;
    
    if (_playingMusic) {
        NSInteger playingIndex = [[self musics] indexOfObject:_playingMusic];
        nextIndex = playingIndex + 1;
        if (nextIndex >= [self musics].count) {
            nextIndex = 0;
        }
    }
    return  [self musics][nextIndex];
}

+ (Music *)previousMusic
{
    NSInteger previousIndex = 0;
    if (_playingMusic) {
        NSInteger playingIndex = [[self musics] indexOfObject:_playingMusic];
        
        previousIndex = playingIndex - 1;
        
        if (previousIndex < 0) {
            previousIndex = [self musics].count - 1;
        }
    }
    return  [self musics][previousIndex];
}
@end
