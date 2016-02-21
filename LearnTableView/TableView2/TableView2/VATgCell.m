//
//  VATgCell.m
//  TableView2
//
//  Created by MS on 15-5-4.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "VATgCell.h"
#import "VATg.h"
@interface VATgCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (weak, nonatomic) IBOutlet UILabel *priceView;
@property (weak, nonatomic) IBOutlet UILabel *buyCountView;

@end

@implementation VATgCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString * ID = @"tg";
    VATgCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"VATgCell" owner:nil options:nil] lastObject];
    }
    return cell;
}
- (void)setTg:(VATg *)tg
{
    _tg = tg;
    
    self.iconView.image = [UIImage imageNamed:tg.icon];
    
    self.titleView.text = tg.title;
    
    self.priceView.text = [NSString stringWithFormat:@"$%@",tg.price];
    
    self.buyCountView.text = [NSString stringWithFormat:@"%@人已购买",tg.buyCount];
    
}
@end
