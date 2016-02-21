//
//  VAAppCell.m
//  TableView6
//
//  Created by MS on 15-5-8.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "VAAppCell.h"
#import "VAApp.h"
@interface VAAppCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *introView;
@property (weak, nonatomic) IBOutlet UIButton *downloadView;
- (IBAction)downloadClick:(UIButton *)sender;

@end

@implementation VAAppCell

-(void)setApp:(VAApp *)app
{
    _app = app;
    
    self.iconView.image = [UIImage imageNamed:app.icon];
    self.nameView.text = app.name;
    self.introView.text = [NSString stringWithFormat:@"大小:%@ | 下载量:%@", app.size, app.download];
    
    self.downloadView.enabled = (self.app.isDownloaded == NO);
    
}

- (IBAction)downloadClick:(UIButton *)sender
{
    self.app.downloaded = YES;
    
    sender.enabled = NO;
    
    if ([self.delegate respondsToSelector:@selector(appCellDidClickedDownloadButton:)]) {
        [self.delegate appCellDidClickedDownloadButton:self];
    }
    
}
@end
