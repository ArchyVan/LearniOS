//
//  ShopCell.m
//  WaterFallFlowLayout
//
//  Created by Archy on 15/6/9.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ShopCell.h"
#import "Shop.h"
#import "UIImageView+WebCache.h"


@interface ShopCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation ShopCell

-(void)setShop:(Shop *)shop
{
    _shop = shop;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:shop.img]];
    self.priceLabel.text = shop.price;
}
@end
