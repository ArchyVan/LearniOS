//
//  CustomStackLayout.m
//  CustomLayout
//
//  Created by Archy on 15/6/9.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#define Random0_1 (arc4random_uniform(100)/100.0)

#import "CustomStackLayout.h"

@implementation CustomStackLayout

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *angles = @[@0, @(-0.2), @(-0.5), @(0.2), @(0.5)];
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    attrs.size = CGSizeMake(100, 100);
    attrs.center = CGPointMake(self.collectionView.frame.size.width * 0.5, self.collectionView.frame.size.height * 0.5);
    
    if (indexPath.item >= 5) {
        attrs.hidden = YES;
    } else {
        attrs.transform = CGAffineTransformMakeRotation([angles[indexPath.item] floatValue]);
        
        attrs.zIndex = [self.collectionView numberOfItemsInSection:indexPath.section] - indexPath.item;
    }
    return attrs;
}
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *array = [NSMutableArray array];
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (int i = 0; i<count; i++) {
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [array addObject:attrs];
    }
    return array;
}
@end
