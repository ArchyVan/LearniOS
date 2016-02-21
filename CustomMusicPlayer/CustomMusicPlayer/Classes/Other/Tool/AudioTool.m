//
//  AudioTool.m
//  CustomMusicPlayer
//
//  Created by Archy on 15/6/15.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "AudioTool.h"

@implementation AudioTool

+ (void)initialize
{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    [session setActive:YES error:nil];
}

static NSMutableDictionary *_soundIDs;

+ (NSMutableDictionary *)soundIDs
{
    if (!_soundIDs) {
        _soundIDs = [NSMutableDictionary dictionary];
    }
    return _soundIDs;
}
static NSMutableDictionary *_musicPlayers;
+ (NSMutableDictionary *)musicPlayers
{
    if (!_musicPlayers) {
        _musicPlayers = [NSMutableDictionary dictionary];
    }
    return _musicPlayers;
}

+ (AVAudioPlayer *)playMusic:(NSString *)filename
{
    if (!filename) {
        return nil;
    }
    
    AVAudioPlayer *player = [self musicPlayers][filename];
    
    if (!player) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        
        if (!url) {
            return  nil;
        }
        
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        
        player.enableRate = YES;
        player.rate = 5.0;
        
        if (![player prepareToPlay]) {
            return nil;
        }
        
        [self musicPlayers][filename] = player;
    }
    
    if (!player.isPlaying) {
        [player play];
    }
    
    return player;

}
+ (void)playSound:(NSString *)filename
{
    if (!filename) {
        return;
    }
    
    SystemSoundID soundID = [[self soundIDs][filename] unsignedLongValue];
    
    if (!soundID) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        if (!url) {
            return;
        }
        
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundID);
        
        [self soundIDs][filename] = @(soundID);
    }
    
    AudioServicesPlaySystemSound(soundID);
}
+ (void)disposeSound:(NSString *)filename
{
    if (!filename) {
        return;
    }
    
    SystemSoundID soundID = [[self soundIDs][filename] unsignedLongValue];
    
    if (soundID) {
        AudioServicesDisposeSystemSoundID(soundID);
        
        [[self soundIDs] removeObjectForKey:filename];
    }
}
@end
