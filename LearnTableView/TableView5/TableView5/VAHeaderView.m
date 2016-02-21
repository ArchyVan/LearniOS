//
//  VAHeaderView.m
//  TableView5
//
//  Created by MS on 15-5-6.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "VAHeaderView.h"
#import "VAFriendGroup.h"
@interface VAHeaderView ()
@property (nonatomic,weak)UILabel * countView;
@property (nonatomic,weak)UIButton * nameView;
@end

@implementation VAHeaderView

+(instancetype)headerViewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"header";
    VAHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) {
        header = [[VAHeaderView alloc]initWithReuseIdentifier:ID];
    }
    return header;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UIButton *nameView = [UIButton buttonWithType:UIButtonTypeCustom];
        // 背景图片
        [nameView setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg"] forState:UIControlStateNormal];
        
        [nameView setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg_highlighted"] forState:UIControlStateHighlighted];
        // 设置按钮内部的左边箭头图片
        [nameView setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        [nameView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 设置按钮的内容左对齐
        nameView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        // 设置按钮的内边距
        nameView.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        nameView.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [nameView addTarget:self action:@selector(nameViewClick) forControlEvents:UIControlEventTouchUpInside];
        // 设置按钮内部的imageView的内容模式为居中
        nameView.imageView.contentMode = UIViewContentModeCenter;
        // 超出边框的内容不需要裁剪
        nameView.imageView.clipsToBounds = NO;
        
        [self.contentView addSubview:nameView];
        self.nameView = nameView;
        // 2.添加好友数
        UILabel *countView = [[UILabel alloc]init];
        countView.textAlignment = NSTextAlignmentRight;
        countView.textColor = [UIColor grayColor];
        [self.contentView addSubview:countView];
        self.countView = countView;
    }
    
    return self;
}

/**
 *  当一个控件的frame发生改变的时候就会调用
 *
 *  一般在这里布局内部的子控件(设置子控件的frame)
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.nameView.frame = self.bounds;
    
    CGFloat countY = 0;
    CGFloat countH = self.frame.size.height;
    CGFloat countW = 150;
    CGFloat countX = self.frame.size.width - 10 -countW;
    self.countView.frame = CGRectMake(countX, countY, countW, countH);
}
-(void)setGroup:(VAFriendGroup *)group
{
    _group = group;
    
    [self.nameView setTitle:group.name forState:UIControlStateNormal];
    
    self.countView.text = [NSString stringWithFormat:@"%d/%ld",group.online,(unsigned long)group.friends.count];
    
    [self didMoveToSuperview];
    
}

- (void)nameViewClick
{
    self.group.opened = ! self.group.isOpened;
    
    if ([self.delegate respondsToSelector:@selector(headerViewDidClickedNameView:)]) {
        [self.delegate headerViewDidClickedNameView:self];
    }
}

/**
 *  当一个控件被添加到父控件中就会调用
 */
-(void)didMoveToSuperview
{
    if (self.group.opened) {
        self.nameView.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    } else {
        self.nameView.imageView.transform = CGAffineTransformMakeRotation(0);
    }
}
@end
