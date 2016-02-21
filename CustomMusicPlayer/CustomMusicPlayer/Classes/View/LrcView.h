//
//  LrcView.h
//  CustomMusicPlayer
//
//  Created by Archy on 15/6/15.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "DRNRealTimeBlurView.h"

@interface LrcView : DRNRealTimeBlurView

@property (nonatomic, copy) NSString *lrcname;

@property (nonatomic, assign) NSTimeInterval currentTime;

@end
