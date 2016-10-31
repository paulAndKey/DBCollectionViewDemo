//
//  ViewController3.m
//  DBCollectionView
//
//  Created by 董宝龙 on 2016/10/25.
//  Copyright © 2016年 dbl. All rights reserved.
//
#define randoms(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#import "ViewController3.h"
#import "Card3DCollectionViewFlowLayout.h"
#import "CardCollectionViewCell.h"
@interface ViewController3 ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic , strong) UICollectionView * collectionView;

@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"卡片3D效果";
    self.view.backgroundColor = [UIColor whiteColor];
    
    Card3DCollectionViewFlowLayout * layout = [[Card3DCollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 40;
    layout.itemSize = CGSizeMake(200, 300);
    layout.sectionInset = UIEdgeInsetsMake(0,self.view.frame.size.width/2-100, 50,self.view.frame.size.width/2-100);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,100, self.view.frame.size.width, 400) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[CardCollectionViewCell class] forCellWithReuseIdentifier:@"CardCollectionViewCell"];
    [self.view addSubview:self.collectionView];
}

#pragma makr - collectionView delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CardCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    int R = (arc4random() % 256) ;
    int G = (arc4random() % 256) ;
    int B = (arc4random() % 256) ;
    cell.imageView.backgroundColor = randoms(R, G, B, 255.0);
    return cell;
}

// 点击item的时候
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //将collectionView在控制器view的中心点转化成collectionView上的坐标,获取collectionView被选中的cell
    CGPoint pInUnderView = [self.view convertPoint:collectionView.center toView:collectionView];
    // 获取中间的indexpath
    NSIndexPath *indexpathNew = [collectionView indexPathForItemAtPoint:pInUnderView];
    if (indexPath.row == indexpathNew.row)
    {
        return;
    }
    else
    {
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
}

@end
