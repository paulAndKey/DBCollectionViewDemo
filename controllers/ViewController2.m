//
//  ViewController2.m
//  DBCollectionView
//
//  Created by 董宝龙 on 2016/10/25.
//  Copyright © 2016年 dbl. All rights reserved.
//

#import "ViewController2.h"
#import "HomePageCollectionFlowLayout.h"
#import "UICollectionViewHeaderView.h"
#import "NewCollectionViewCell.h"
#import "BannerCollectionViewCell.h"
@interface ViewController2 ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic , strong) UICollectionView * collectionView;
@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"防电商app首页";
    self.view.backgroundColor = [UIColor whiteColor];
    
    HomePageCollectionFlowLayout * layout = [[HomePageCollectionFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"RollCell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.collectionView registerClass:[NewCollectionViewCell class] forCellWithReuseIdentifier:@"newCell"];
    [self.collectionView registerClass:[BannerCollectionViewCell class] forCellWithReuseIdentifier:@"bannerCell"];
    [self.view addSubview:self.collectionView];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [@[@"1",@"1",@"3",@"7"][section] intValue];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        BannerCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"bannerCell" forIndexPath:indexPath];
        return cell;
    }
    if (indexPath.section == 1) {
        NewCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"newCell" forIndexPath:indexPath];
        [cell addValueCellWithArray:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7"]];
        return cell;
    }else{
        UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RollCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor greenColor];
        return cell;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
    UICollectionViewHeaderView * headerView = [[UICollectionViewHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 35) title:@[@"新品上市",@"热卖",@"推荐产品"][indexPath.section-1]];
    
    [reusableView addSubview:headerView];
    return reusableView;
}

@end
