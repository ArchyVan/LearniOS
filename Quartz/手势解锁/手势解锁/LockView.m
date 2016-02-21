//
//  LockView.m
//  手势解锁
//
//  Created by Archy on 15/5/18.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "LockView.h"

@interface LockView ()

@property (nonatomic, strong) NSMutableArray *btns;

@property (nonatomic, assign) CGPoint moveP;

@end

@implementation LockView

-(NSMutableArray *)btns
{
    if (nil == _btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self addButtons];
        NSLog(@"%s",__func__);
    }
    return self;
}
- (void)addButtons
{
    for (int i = 0; i < 9; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[[UIImage imageNamed:@"gesture_node_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        
        [button setImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        
        
        button.userInteractionEnabled = NO;
        
        [self addSubview:button];
    }
}
- (CGPoint)pointWithTouches:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    return [touch locationInView:self];
}
- (UIButton *)buttonWithPoint:(CGPoint)point
{
    for (UIButton *btn  in self.subviews) {
        if (CGRectContainsPoint(btn.frame, point)) {
            return btn;
        }
    }
    return nil;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint pos = [self pointWithTouches:touches];
    
    UIButton *btn = [self buttonWithPoint:pos];
    
    if (btn && btn.selected == NO) {
        btn.selected = YES;
        [_btns addObject:btn];
    }
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint pos = [self pointWithTouches:touches];
    
    _moveP = pos;
    
    UIButton *btn = [self buttonWithPoint:pos];
    
    if (btn && btn.selected == NO) {
        btn.selected =YES;
        
        [_btns addObject:btn];
    }
    
    [self setNeedsDisplay];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger col = 0;
    NSInteger row = 0;
    
    CGFloat btnW = 74;
    CGFloat btnH = 74;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    
    CGFloat tolCol = 3;
    CGFloat margin = (self.bounds.size.width - tolCol*btnW) / (tolCol +1);
    for (int i = 0; i<self.subviews.count; i++) {
        UIButton *button = self.subviews[i];
        
        col = i%3;
        row = i/3;
        btnX = margin + (margin + btnW)*col;
        btnY = (margin + btnH) * row;
        
        button.frame = CGRectMake(btnX, btnY, btnW, btnH);
        button.tag =col*3+row;
        
    }
}
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    for (int i = 0; i < self.btns.count; i++) {
        UIButton *btn = _btns[i];
        
        if (0 == i) {
            [path moveToPoint:btn.center];
        } else {
            [path addLineToPoint:btn.center];
        }
    }
    
    [path addLineToPoint:_moveP];
    
    [[UIColor colorWithRed:1.000 green:0.327 blue:0.105 alpha:0.800] set];
    
    path.lineWidth = 8;
    path.lineJoinStyle = kCGLineJoinRound;
    
    [path stroke];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSMutableString *str = [NSMutableString string];
    for (UIButton *button in self.btns) {
        [str appendFormat:@"%ld",button.tag];
    }
    NSLog(@"%@",str);
    [self.btns makeObjectsPerformSelector:@selector(setSelected:) withObject:@NO];
    
    [self.btns removeAllObjects];
    
    [self setNeedsDisplay];
}
@end
