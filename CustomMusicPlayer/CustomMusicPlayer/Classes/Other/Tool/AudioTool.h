//
//  AudioTool.h
//  CustomMusicPlayer
//
//  Created by Archy on 15/6/15.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface AudioTool : NSObject

+ (AVAudioPlayer *)playMusic:(NSString *)filename;

+ (void)pauseMusic:(NSString *)filrname;

+ (void)stopMusic:(NSString *)filename;

+ (void)playSound:(NSString *)filename;

+ (void)disposeSound:(NSString *)filename;

@end
