//
//  WheelView.m
//  Wheel
//
//  Created by Archy on 15/5/22.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "WheelView.h"
#import "WheelButton.h"

#define angle2radian(x) ((x) / 180.0 * M_PI)

@interface WheelView ()
@property (weak, nonatomic) IBOutlet UIImageView *rotateView;

@property (nonatomic, weak) UIButton *selectedButton;

@property (strong, nonatomic) CADisplayLink *link;


@end

@implementation WheelView

+ (instancetype)wheelView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"WheelView" owner:nil options:nil]lastObject];
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        NSLog(@"%@",_rotateView);
    }
    return self;
}
- (void)awakeFromNib
{
    _rotateView.userInteractionEnabled = YES;
    
    UIImage *bigImage = [UIImage imageNamed:@"LuckyAstrology"];
    UIImage *selectedImage = [UIImage imageNamed:@"LuckyAstrologyPressed"];
    
    CGFloat imageW = 40 * [UIScreen mainScreen].scale;
    CGFloat imageH = 47 * [UIScreen mainScreen].scale;
    
    for (NSInteger i = 0; i < 12; i++) {
        WheelButton *button = [WheelButton buttonWithType:UIButtonTypeCustom];
        
        button.layer.anchorPoint = CGPointMake(0.5, 1);
        button.layer.position = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
        
        button.layer.transform = CATransform3DMakeRotation(angle2radian(i * 30), 0, 0, 1);
        
        button.bounds = CGRectMake(0, 0, 68, 143);
        
        [button setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        
        
        CGRect clipRect = CGRectMake(i * imageW, 0, imageW, imageH);
        
        CGImageRef smallImage = CGImageCreateWithImageInRect(bigImage.CGImage, clipRect);
        [button setImage:[UIImage imageWithCGImage:smallImage] forState:UIControlStateNormal];
        
        CGImageRef selectedSmallImage = CGImageCreateWithImageInRect(selectedImage.CGImage, clipRect);
        [button setImage:[UIImage imageWithCGImage:selectedSmallImage] forState:UIControlStateSelected];
        
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        if (i==0) {
            [self btnClick:button];
        }
        
        [_rotateView addSubview:button];
    }
}
- (void)btnClick:(UIButton *)button
{
    _selectedButton.selected = NO;
    button.selected = YES;
    _selectedButton = button;
}
- (void)startRotating
{
    self.link.paused = NO;
}
- (void)stopRotating
{
    _link.paused = YES;
}
-(CADisplayLink *)link
{
    if (_link == nil) {
        CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
        [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        _link = link;
    }
    return _link;
}

- (void)update
{
    _rotateView.transform = CGAffineTransformRotate(_rotateView.transform, angle2radian(45 / 60.0));
}
- (IBAction)start:(id)sender {
    
    _rotateView.userInteractionEnabled = NO;
    
    [self stopRotating];
    
    CABasicAnimation *anim = [CABasicAnimation animation];
    
    anim.keyPath = @"transform.rotation";
    
    anim.toValue = @(M_PI * 2 * 3);
    
    anim.duration = 0.5;
    
    anim.delegate = self;
    
    [_rotateView.layer addAnimation:anim forKey:nil];
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    _rotateView.userInteractionEnabled = YES;
    
    CGFloat angle = atan2(_selectedButton.transform.b, _selectedButton.transform.a);
    
    _rotateView.transform = CGAffineTransformMakeRotation(- angle);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startRotating];
    });
}

@end
