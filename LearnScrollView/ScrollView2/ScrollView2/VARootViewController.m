//
//  VARootViewController.m
//  ScrollView2
//
//  Created by MS on 15-5-7.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#define WIDTH_OF_SCROLL_PAGE  320

#define HEIGHT_OF_SCROLL_PAGE  480

#define WIDTH_OF_IMAGE 320 

#define HEIGHT_OF_IMAGE 480

#define LEFT_EDGE_OFSET 0

#import "VARootViewController.h"

@interface VARootViewController ()<UIScrollViewDelegate>
{
    UIScrollView * _scrollView;
    NSMutableArray * slideImages;
}
@end

@implementation VARootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    _scrollView = [[UIScrollView alloc] init];
    
    CGRect scrollFrame;
    
    scrollFrame.origin.x = 0;
    
    scrollFrame.origin.y = 0;
    
    scrollFrame.size.width = WIDTH_OF_SCROLL_PAGE;
    
    scrollFrame.size.height = HEIGHT_OF_SCROLL_PAGE;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:scrollFrame];
    
    _scrollView.bounces = YES;
    
    _scrollView.pagingEnabled = YES;
    
    _scrollView.delegate = self;
    
    _scrollView.userInteractionEnabled = YES;
    
    slideImages = [[NSMutableArray alloc] init];
    
    [slideImages addObject:@"美女20.jpg"];
    
    [slideImages addObject:@"美女21.jpg"];
    
    [slideImages addObject:@"美女22.jpg"];
    
    [slideImages addObject:@"美女23.jpg"];
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[slideImages objectAtIndex:([slideImages count]-1)]]];
    
    imageView.frame = CGRectMake(LEFT_EDGE_OFSET, 0, WIDTH_OF_IMAGE, HEIGHT_OF_IMAGE);
    
    [_scrollView addSubview:imageView];
    
    for (int i = 0;i<[slideImages count];i++) {
        
        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[slideImages objectAtIndex:i]]];
        
        imageView.frame = CGRectMake((320 * i) + LEFT_EDGE_OFSET + 320, 0, 320, 480);
        
        [_scrollView addSubview:imageView];
        
        
    }
    
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[slideImages objectAtIndex:0]]];
    
    imageView.frame = CGRectMake((WIDTH_OF_IMAGE * ([slideImages count] + 1)) + LEFT_EDGE_OFSET, 0, WIDTH_OF_IMAGE, HEIGHT_OF_IMAGE);  
    
    [_scrollView addSubview:imageView];
    
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    _scrollView.showsVerticalScrollIndicator = NO;
    
    _scrollView.bounces = NO;
    
    [_scrollView setContentSize:CGSizeMake(WIDTH_OF_SCROLL_PAGE * ([slideImages count] + 2), HEIGHT_OF_IMAGE)];
    
    [_scrollView setContentOffset:CGPointMake(0, 0)];
    
    [self.view addSubview:_scrollView];
    
    [_scrollView scrollRectToVisible:CGRectMake(WIDTH_OF_IMAGE,0,WIDTH_OF_IMAGE,HEIGHT_OF_IMAGE) animated:YES];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    int currentPage = floor((scrollView.contentOffset.x - scrollView.frame.size.width/ ([slideImages count]+2)) /scrollView.frame.size.width) + 1;
    
    if (currentPage==0)
    {
        
    [scrollView scrollRectToVisible:CGRectMake(WIDTH_OF_IMAGE * [slideImages count],0,WIDTH_OF_IMAGE,HEIGHT_OF_IMAGE) animated:YES];
        
    } else if (currentPage==([slideImages count]+1)){
            
        [scrollView scrollRectToVisible:CGRectMake(WIDTH_OF_IMAGE,0,WIDTH_OF_IMAGE,HEIGHT_OF_IMAGE) animated:NO];
    
    }
    
}

@end
