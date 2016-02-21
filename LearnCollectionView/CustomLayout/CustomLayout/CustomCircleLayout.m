//
//  CustomCircleLayout.m
//  CustomLayout
//
//  Created by Archy on 15/6/9.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "CustomCircleLayout.h"

@implementation CustomCircleLayout

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    attrs.size = CGSizeMake(50, 50);
    
    CGFloat circleRadius = 70;
    CGPoint circleCenter = CGPointMake(self.collectionView.frame.size.width * 0.5, self.collectionView.frame.size.height * 0.5);
    CGFloat angleData = M_PI * 2 / [self.collectionView numberOfItemsInSection:indexPath.section];
    
    CGFloat angle = indexPath.item * angleData;
    
    attrs.center = CGPointMake(circleCenter.x + circleRadius * cosf(angle), circleCenter.y - circleRadius * sinf(angle));

    attrs.zIndex = indexPath.item;
    
    return attrs;
}
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *array = [NSMutableArray array];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    if (count == 1) {
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        CGPoint center = attr.center;
        center.y = self.collectionView.center.y - 100;
        center.x = self.collectionView.center.x;
        attr.center = center;
        attr.size = CGSizeMake(100, 100);
        [array addObject:attr];
    } else {
        
        for (int i = 0; i<count; i++) {
            UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
            [array addObject:attrs];
        }
    }
    return array;
}
@end
