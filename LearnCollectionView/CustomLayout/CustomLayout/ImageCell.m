//
//  ImageCell.m
//  CustomFlowLayout
//
//  Created by Archy on 15/6/9.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ImageCell.h"

@interface ImageCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ImageCell

- (void)awakeFromNib {
    // Initialization code
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageView.layer.borderWidth = 2;
    self.imageView.layer.cornerRadius = 2;
    self.imageView.clipsToBounds = YES;
}
-(void)setImage:(NSString *)image
{
    _image = [image copy];
    
    self.imageView.image = [UIImage imageNamed:image];
}

@end
