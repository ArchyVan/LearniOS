//
//  ViewController.m
//  ScrollView
//
//  Created by MS on 15-5-3.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#define ImageCount 5

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIScrollView *bigScrollView;

@property (weak, nonatomic) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGFloat imageW = self.scrollView.frame.size.width;
    CGFloat imageH = self.scrollView.frame.size.height;
    CGFloat imageY = 0;
    
    for (int i = 0; i<ImageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        
        CGFloat imageX = i * imageW;
        
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        
        NSString *name = [NSString stringWithFormat:@"img_0%d",i+1];
        
        imageView.image = [UIImage imageNamed:name];
        
        [self.scrollView addSubview:imageView];
    }
    
    CGFloat contentW = ImageCount * imageW;
    
    self.scrollView.contentSize = CGSizeMake(contentW, 0);
    
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    self.scrollView.pagingEnabled = YES;
    
    self.pageControl.numberOfPages = ImageCount;
    
    self.bigScrollView.contentSize = CGSizeMake(320, 441+145);
    
    self.bigScrollView.showsVerticalScrollIndicator = NO;
    
    self.bigScrollView.showsHorizontalScrollIndicator = NO;
    
    [self addTimer];

}

- (void)addTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}
- (void)removeTimer
{
    [self.timer invalidate];
    
    self.timer = nil;
}
- (void)nextImage
{
    NSInteger page = 0;
    
    if (self.pageControl.currentPage == ImageCount - 1) {
        
        page = 0;
        
    }else{
        
        page = self.pageControl.currentPage + 1;
        
    }
    
    CGFloat  offsetX = page * self.scrollView.frame.size.width;
    
    CGPoint offset =CGPointMake(offsetX, 0);
    
    [self.scrollView setContentOffset:offset animated:YES];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
        CGFloat scrollW = scrollView.frame.size.width;
        
        int page = (self.scrollView.contentOffset.x + scrollW*0.5)/scrollW;
        
        self.pageControl.currentPage = page;
        
        NSLog(@"%d",page);

}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [self removeTimer];
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}
@end
