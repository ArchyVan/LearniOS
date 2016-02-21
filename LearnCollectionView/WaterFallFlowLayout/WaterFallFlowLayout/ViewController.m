//
//  ViewController.m
//  WaterFallFlowLayout
//
//  Created by Archy on 15/6/9.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"
#import "WaterFlowLayout.h"
#import "Shop.h"
#import "ShopCell.h"
#import "MJRefresh.h"
#import "MJExtension.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,WaterFlowLayoutDelegate>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *shops;

@end

@implementation ViewController

- (NSMutableArray *)shops
{
    if (_shops == nil) {
        self.shops = [NSMutableArray array];
    }
    return _shops;
}

static NSString *const ID = @"shop";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *shopArray = [Shop objectArrayWithFile:@"1.plist"];
    
    [self.shops addObjectsFromArray:shopArray];
    
    WaterFlowLayout *layout = [[WaterFlowLayout alloc] init];
    layout.delegate = self;
    layout.columnsCount = 2;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:@"ShopCell" bundle:nil] forCellWithReuseIdentifier:ID];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    [self.collectionView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreShops)];
    [self.collectionView.footer beginRefreshing];
}
- (void)loadMoreShops
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSArray *shopArray = [Shop objectArrayWithFilename:@"1.plist"];
        [self.shops addObjectsFromArray:shopArray];
        [self.collectionView reloadData];
        [self.collectionView.footer endRefreshing];
        
    });
}
#pragma mark - WaterFlowLayoutDelegate
- (CGFloat)waterFlowLayout:(WaterFlowLayout *)waterFlowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath
{
    //得到当前indexPath所对应的数据模型
    Shop *shop = self.shops[indexPath.item];
    //计算出它的宽高比
    CGFloat proportion = shop.h / shop.w;
    //返回它的高度
    CGFloat height = proportion * width;
    return height;
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.shops.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.shop = self.shops[indexPath.item];
    
    return cell;
}
@end
