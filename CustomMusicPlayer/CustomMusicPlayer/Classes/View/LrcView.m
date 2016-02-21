//
//  LrcView.m
//  CustomMusicPlayer
//
//  Created by Archy on 15/6/15.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "LrcView.h"
#import "LrcCell.h"
#import "LrcLine.h"
#import "UIView+QuickCreate.h"

@interface LrcView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *lrcLines;
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation LrcView
- (NSMutableArray *)lrcLines
{
    if (_lrcLines == nil) {
        self.lrcLines = [NSMutableArray array];
    }
    return _lrcLines;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}
- (void)setup
{
    UITableView *tableView = [[UITableView alloc] init];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self addSubview:tableView];
    self.tableView = tableView;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.tableView.frame = self.bounds;
    self.tableView.contentInset = UIEdgeInsetsMake(self.tableView.height * 0.5, 0, self.tableView.height * 0.5, 0);
}

- (void)setLrcname:(NSString *)lrcname
{
    _lrcname = [lrcname copy];
    
    [self.lrcLines removeAllObjects];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:lrcname withExtension:nil];
    NSString *lrcStr = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    NSArray *lrcCmps = [lrcStr componentsSeparatedByString:@"\n"];
    
    for (NSString *lrcCmp in lrcCmps) {
        LrcLine *line = [[LrcLine alloc] init];
        [self.lrcLines addObject:line];
        if (![lrcCmp hasPrefix:@"["]) {
            continue;
        }
        
        if ([lrcCmp hasPrefix:@"[ti:"] || [lrcCmp hasPrefix:@"[ar:"] || [lrcCmp hasPrefix:@"al:"]) {
            NSString *word = [[lrcCmp componentsSeparatedByString:@":"] lastObject];
            
            line.word = [word substringToIndex:word.length - 1];
        } else {
            NSArray *array = [lrcCmp componentsSeparatedByString:@"]"];
            line.time = [[array firstObject]  substringFromIndex:1];
            line.word = [array lastObject];
        }
    }
    
    [self.tableView reloadData];
}

- (void)setCurrentTime:(NSTimeInterval)currentTime
{
    if (currentTime < _currentTime) {
        self.currentIndex = -1;
    }
    _currentTime = currentTime;
    
    int minute = currentTime / 60;
    int second = (int)currentTime % 60;
    int msecond = (currentTime - (int)currentTime) * 100;
    NSString *currentTimeStr = [NSString stringWithFormat:@"%02d:%02d.%02d", minute, second, msecond];
    NSInteger count = self.lrcLines.count;
    
    for (NSInteger idx = self.currentIndex + 1; idx < count; idx++) {
        LrcLine *currentLine = self.lrcLines[idx];
        NSString *currentLineTime = currentLine.time;
        
        NSString *nextLineTime = nil;
        
        NSUInteger nextIdx = idx + 1;
        
        if (nextIdx < self.lrcLines.count) {
            LrcLine *nextLine = self.lrcLines[nextIdx];
            nextLineTime = nextLine.time;
        }
        
        if (([currentTimeStr compare:currentLineTime] != NSOrderedAscending)
            && ([currentTimeStr compare:nextLineTime] == NSOrderedAscending)
            && self.currentIndex != idx) {
            NSArray *reloadRows = @[[NSIndexPath indexPathForRow:self.currentIndex inSection:0],[NSIndexPath indexPathForRow:idx inSection:0]];
            
            self.currentIndex = idx;
            
            [self.tableView reloadRowsAtIndexPaths:reloadRows withRowAnimation:UITableViewRowAnimationNone];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
            
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.lrcLines.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LrcCell *cell = [LrcCell cellWithTableView:tableView];
    
    cell.lrcLine = self.lrcLines[indexPath.row];
    
    if (self.currentIndex == indexPath.row) {
        cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
    } else {
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    }
    
    return cell;
}
@end





