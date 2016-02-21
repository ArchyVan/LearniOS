//
//  Music.h
//  CustomMusicPlayer
//
//  Created by Archy on 15/6/15.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Music : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *filename;
@property (nonatomic, copy) NSString *lrcname;
@property (nonatomic, copy) NSString *singer;
@property (nonatomic, copy) NSString *singerIcon;

@end
