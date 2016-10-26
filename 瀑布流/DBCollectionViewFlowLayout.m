//
//  DBCollectionViewFlowLayout.m
//  DBCollectionView
//
//  Created by 董宝龙 on 2016/10/25.
//  Copyright © 2016年 dbl. All rights reserved.
//

#import "DBCollectionViewFlowLayout.h"
#define UI_width [UIScreen mainScreen].bounds.size.width
/** 每一行的间距*/
static const CGFloat defaultRowMargin = 10;
/** 每一列的间距*/
static const CGFloat defaultColumnMargin = 10;
/** 每一列之前的间距 top,left,bottom,right */
static const UIEdgeInsets defaultInsets = {10,10,10,10};
/** 默认多少列*/
static const int defaultColumsCount = 3;

@interface DBCollectionViewFlowLayout ()

/** 存放每一列的最大Y值 */
@property (nonatomic , strong) NSMutableArray * columnMaxY;

/** 存放所有cell的布局属性*/
@property (nonatomic , strong) NSMutableArray * attributesArray;

@end

@implementation DBCollectionViewFlowLayout

- (NSMutableArray *)columnMaxY {
    if (!_columnMaxY) {
        _columnMaxY = [[NSMutableArray alloc] init];
    }
    return _columnMaxY;
}

- (NSMutableArray *)attributesArray {
    if (!_attributesArray) {
        _attributesArray = [[NSMutableArray alloc] init];
    }
    return _attributesArray;
}

#pragma 重写一下内部方法
/**
 * 返回collectionView的contentSize
    计算方式为：计算出最长那一列的最大Y值，即 columnMaxY的最大值+行间距
 */
- (CGSize)collectionViewContentSize {
    //找出最长那一列的最大值
    CGFloat MaxY = [_columnMaxY[0] doubleValue];
    for (NSInteger i = 0; i < _columnMaxY.count; i ++) {
        //取出第i列的最大Y值
        CGFloat columnMaxY = [_columnMaxY[i] doubleValue];
        //找出最大的Y值
        if (columnMaxY > MaxY) {
            MaxY = columnMaxY;
        }
    }
    return CGSizeMake(UI_width, MaxY + defaultInsets.bottom);
}

- (void)prepareLayout {
    [super prepareLayout];
    [self columnMaxY];
    [self attributesArray];
    
    for (NSInteger i = 0; i < defaultColumsCount; i ++) {
        [_columnMaxY addObject:@(defaultInsets.top)];
    }
    
    //计算所有cell的布局属性
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; i ++) {
        NSIndexPath * indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes * attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [_attributesArray addObject:attrs];
    }
}

/**
 返回cell的所有布局属性
 */
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attributesArray;
}

/**
 计算cell的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes * attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //计算indexPath位置cell的属性
    
    //水平方向上的总间距
    CGFloat xMargin = defaultInsets.left + defaultInsets.right + defaultColumnMargin * (defaultColumsCount - 1);
    //cell的宽度
    CGFloat cellWidth = (self.collectionView.frame.size.width - xMargin) / defaultColumsCount;
    //cell的高度，测试数据（随机数）
    CGFloat cellHeight = 50 + arc4random_uniform(150);
    
    //找出最短那一列的 列号 和 它的最大Y值
    CGFloat maxY = [_columnMaxY[0] doubleValue];
    NSInteger destColumn = 0;
    for (NSInteger i = 0; i < _columnMaxY.count; i ++) {
        CGFloat columnMaxY = [_columnMaxY[i] doubleValue];
        //找出最短的那列列号
        if (columnMaxY < maxY) {
            maxY = columnMaxY;
            destColumn = i;
        }
    }
    //cell的x值
    CGFloat x = defaultInsets.left + destColumn * (cellWidth + defaultColumnMargin);
    //cell的y值
    CGFloat y = maxY + defaultRowMargin;
    //cell的frame
    attributes.frame = CGRectMake(x, y, cellWidth, cellHeight);
    
    //更新数组中的最大Y值
    self.columnMaxY[destColumn] = @(CGRectGetMaxY(attributes.frame));
    
    return attributes;
}
@end
