//
//  ViewController.m
//  Clock
//
//  Created by Archy on 15/5/21.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"

#define perSecendA 6
#define perMinuteA 6
#define perHourA 30

#define perMinuterHourA 0.5
#define angle2radian(x) ((x) / 180 * M_PI)

@interface ViewController ()
{
    CALayer *_second;
    CALayer *_minute;
    CALayer *_hour;
}
@property (weak, nonatomic) IBOutlet UIImageView *clockView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addHour];
    [self addMintue];
    [self addSecond];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(update) userInfo:nil repeats:YES];
    [self update];
}

- (void)addHour
{
    CGFloat imageW = _clockView.bounds.size.width;
    CGFloat imageH = _clockView.bounds.size.height;
    
    CALayer *hour = [CALayer layer];
    
    hour.anchorPoint = CGPointMake(0.5, 1);
    
    hour.position = CGPointMake(imageW * 0.5, imageH * 0.5);
    
    hour.bounds = CGRectMake(0, 0, 4, imageH * 0.5 - 50);
    
    hour.backgroundColor = [UIColor blackColor].CGColor;
    
    hour.cornerRadius = 4;
    
    [_clockView.layer addSublayer:hour];
    
    _hour = hour;
}
- (void)addMintue
{
    CGFloat imageW = _clockView.bounds.size.width;
    CGFloat imageH = _clockView.bounds.size.height;
    
    CALayer *minute = [CALayer layer];
    
    minute.anchorPoint = CGPointMake(0.5, 1);
    
    minute.position = CGPointMake(imageW * 0.5, imageH * 0.5);
    
    minute.bounds = CGRectMake(0, 0, 2, imageH * 0.5 - 30);
    
    minute.backgroundColor = [UIColor blueColor].CGColor;
    
    [_clockView.layer addSublayer:minute];
    
    _minute = minute;
}

// 添加秒针
- (void)addSecond
{
    CGFloat imageW = _clockView.bounds.size.width;
    CGFloat imageH = _clockView.bounds.size.height;
    
    CALayer *second = [CALayer layer];
    
    second.anchorPoint = CGPointMake(0.5, 1);
    
    second.position = CGPointMake(imageW * 0.5, imageH * 0.5);
    
    second.bounds = CGRectMake(0, 0, 1, imageH * 0.5 - 20);
    
    second.backgroundColor = [UIColor redColor].CGColor;
    
    [_clockView.layer addSublayer:second];
    
    _second = second;
}
- (void)update
{
    //获取日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //获取日期组件
    NSDateComponents *compoents = [calendar components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour fromDate:[NSDate date]];
    
    CGFloat sec = compoents.second;
    CGFloat minute = compoents.minute;
    CGFloat hour = compoents.hour;
    
    CGFloat secondA = sec * perSecendA;
    CGFloat minuteA = minute * perMinuteA;
    CGFloat hourA = hour * perHourA;
    hourA += minute * perMinuterHourA;
    
    _second.transform = CATransform3DMakeRotation(angle2radian(secondA), 0, 0, 1);
    _minute.transform = CATransform3DMakeRotation(angle2radian(minuteA), 0, 0, 1);
    _hour.transform = CATransform3DMakeRotation(angle2radian(hourA), 0, 0, 1);
}
@end
