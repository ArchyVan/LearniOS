//
//  CustomLineFlowLayout.m
//  CustomFlowLayout
//
//  Created by Archy on 15/6/9.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "CustomLineFlowLayout.h"

static const CGFloat ItemWH = 100.0f;

@implementation CustomLineFlowLayout

- (id)init
{
    if(self = [super init])
    {
    }
    return self;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGRect lastRect;
    lastRect.origin = proposedContentOffset;
    lastRect.size = self.collectionView.frame.size;
    
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    NSArray *array = [self layoutAttributesForElementsInRect:lastRect];
    
    CGFloat adjustOffsetX = MAXFLOAT;
    
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (ABS(attrs.center.x - centerX) < ABS(adjustOffsetX)) {
            adjustOffsetX = attrs.center.x - centerX;
        }
    }
    return CGPointMake(proposedContentOffset.x + adjustOffsetX, proposedContentOffset.y);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

-(void)prepareLayout
{
    [super prepareLayout];
    
    self.itemSize = CGSizeMake(ItemWH, ItemWH);
    
    CGFloat inset = (self.collectionView.frame.size.width - ItemWH) * 0.5;
    
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = ItemWH * 0.7;
}

static CGFloat const ActiveDistance = 187.5f;
static CGFloat const ScaleFactor = 0.6;

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    CGRect visiableRect;
    visiableRect.size = self.collectionView.frame.size;
    visiableRect.origin = self.collectionView.contentOffset;
    
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (!CGRectIntersectsRect(visiableRect, attrs.frame)) {
            continue;
        }
        
        CGFloat itemCenterX = attrs.center.x;
        
        CGFloat scale = 1 + ScaleFactor * (1 - (ABS(itemCenterX - centerX) / ActiveDistance));
        attrs.transform = CGAffineTransformMakeScale(scale, scale);
        
    }
    return array;
}

@end
