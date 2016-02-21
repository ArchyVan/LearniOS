//
//  WaterFlowLayout.h
//  WaterFallFlowLayout
//
//  Created by Archy on 15/6/9.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaterFlowLayout;

@protocol WaterFlowLayoutDelegate <NSObject>
/**
 *  得到每一个item宽度所对应的高度
 *
 *  @param waterFlowLayout 当前的瀑布流布局
 *  @param width           每一个item的宽度（由列数决定）
 *  @param indexPath       每一个item的indexPath
 *
 *  @return 每一个item宽度所对应的高度
 */
- (CGFloat)waterFlowLayout:(WaterFlowLayout *)waterFlowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;

@end

@interface WaterFlowLayout : UICollectionViewLayout
/** 瀑布流布局的边距 */
@property (nonatomic, assign) UIEdgeInsets sectionInset;
/** 每一列之间的间距 */
@property (nonatomic, assign) CGFloat columnMargin;
/** 每一行之间的间距 */
@property (nonatomic, assign) CGFloat rowMargin;
/** 总共有几列 */
@property (nonatomic, assign) NSInteger columnsCount;
/** 设置遵守<WaterFlowLayoutDelegate>的代理 */
@property (nonatomic, weak) id<WaterFlowLayoutDelegate> delegate;


@end
