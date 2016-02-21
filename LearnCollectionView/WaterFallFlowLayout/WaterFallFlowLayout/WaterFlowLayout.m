//
//  WaterFlowLayout.m
//  WaterFallFlowLayout
//
//  Created by Archy on 15/6/9.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "WaterFlowLayout.h"
#define DefaultMargin 10

@interface WaterFlowLayout ()

/** 这个字典用来存储每一列最大的Y值 */
@property (nonatomic, strong) NSMutableDictionary *maxYDict;
/** 存放所有的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArray;

@end

@implementation WaterFlowLayout
//懒加载
- (NSMutableDictionary *)maxYDict
{
    if (!_maxYDict) {
        self.maxYDict = [NSMutableDictionary dictionary];
    }
    return _maxYDict;
}

- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        self.attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        //初始化一些默认值
        self.columnMargin = DefaultMargin;
        self.rowMargin = DefaultMargin;
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        self.columnsCount = 3;
    }
    return self;
}
//每一次发生布局变化的时候是否改变的方法（必须写）
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

/**
 *  每次布局之前的准备
 */
- (void)prepareLayout
{
    [super prepareLayout];
    // 1.清空最大的Y值
    for (int i = 0 ; i < self.columnsCount; i++) {
        NSString *column = [NSString stringWithFormat:@"%d",i];
        self.maxYDict[column] = @(self.sectionInset.top);
    }
    
    // 2.计算所有cell的属性
    [self.attrsArray removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i++) {
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        
        [self.attrsArray addObject:attrs];
    }
}
//设置当前collectionView的ContentSize
- (CGSize)collectionViewContentSize
{
    __block NSString *maxColumn = @"0";
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
        
        if ([maxY floatValue] > [self.maxYDict[maxColumn] floatValue]) {
            maxColumn = column;
        }
        
    }];
    return CGSizeMake(0, [self.maxYDict[maxColumn] floatValue] + self.sectionInset.bottom);
}


/**
 *  返回indexPath这个位置Item的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //初始化最短那列为第0列
    __block NSString *minColumn = @"0";
    //遍历字典找到当前最短那列
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
        
        if ([maxY floatValue] < [self.maxYDict[minColumn] floatValue]) {
            minColumn = column;
        }
        
    }];
    
    //每一列的宽度计算
    CGFloat width = (self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right - (self.columnsCount - 1) * self.columnMargin) / self.columnsCount;
    //每一个item的高度
    CGFloat height = [self.delegate waterFlowLayout:self heightForWidth:width atIndexPath:indexPath];
    //最短那列的x
    CGFloat x = self.sectionInset.left + (width + self.columnMargin) * [minColumn intValue];
    //最短那列的y
    CGFloat y = [self.maxYDict[minColumn] floatValue] + self.rowMargin;
    //将item的最大Y值属性存入字典
    self.maxYDict[minColumn] = @(y + height);
    //实例化一个参数属性对象
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //给参数属性对象赋值
    attrs.frame = CGRectMake(x, y, width, height);
    return attrs;
    
}
//返回所有item的参数属性（必须写）
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //返回所有的参数属性
    return self.attrsArray;
}
@end
