//
//  ViewController.m
//  CustomLayout
//
//  Created by Archy on 15/6/9.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"
#import "ImageCell.h"
#import "CustomStackLayout.h"
#import "CustomCircleLayout.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation ViewController

static NSString *const ID = @"image";
-(NSMutableArray *)images
{
    if (!_images) {
        self.images = [NSMutableArray array];
        
        for (int i = 0; i<20; i++) {
            [self.images addObject:[NSString stringWithFormat:@"shuimu%d",i]];
        }
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat Width = self.view.frame.size.width;
    
    CGRect rect = CGRectMake(0, 100, Width, 200);
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:rect collectionViewLayout:[[CustomCircleLayout alloc] init]];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [collectionView registerNib:[UINib nibWithNibName:@"ImageCell" bundle:nil] forCellWithReuseIdentifier:ID];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.collectionView.collectionViewLayout isKindOfClass:[CustomStackLayout class]]) {
        [self.collectionView setCollectionViewLayout:[[CustomCircleLayout alloc] init] animated:YES];
    } else {
        [self.collectionView setCollectionViewLayout:[[CustomStackLayout alloc] init] animated:YES];
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.images.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.image = self.images[indexPath.item];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.images removeObjectAtIndex:indexPath.item];
    
    [collectionView deleteItemsAtIndexPaths:@[indexPath]];
}
@end
