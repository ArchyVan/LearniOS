//
//  ViewController.m
//  PageAnimation
//
//  Created by Archy on 15/6/14.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) UIImageView *imageView;

@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, assign) NSInteger index;

@end

@implementation ViewController

- (NSMutableArray *)imageArray
{
    if (!_imageArray) {
        _imageArray = [NSMutableArray arrayWithContentsOfFile:@"aaa"];
    }
    return _imageArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _index = 0;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_index == self.imageArray.count - 1) {
        _index = 0;
    }
    
    _imageView.image = [UIImage imageNamed:_imageArray[_index]];
    
    CATransition *anim = [CATransition animation];
    
    anim.type = @"pageCurl";
    
    anim.subtype = kCATransitionFromRight;
    
    anim.duration = 2;
    
    [_imageView.layer addAnimation:anim forKey:nil];
    
}

@end
