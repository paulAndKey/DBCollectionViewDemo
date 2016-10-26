//
//  HomePageCollectionFlowLayout.m
//  DBCollectionView
//
//  Created by 董宝龙 on 2016/10/26.
//  Copyright © 2016年 dbl. All rights reserved.
//

#define UI_width [UIScreen mainScreen].bounds.size.width
#define UI_height [UIScreen mainScreen].bounds.size.height


#import "HomePageCollectionFlowLayout.h"

//每个分区头视图的高度
static const CGFloat sectionHeaderHight = 35;

@interface HomePageCollectionFlowLayout ()

//布局数组
@property (nonatomic , strong) NSMutableArray * attributesArray;

@end

@implementation HomePageCollectionFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.attributesArray = [[NSMutableArray alloc] init];
    
    [self attributesSection0];
    [self attributesSection1];
    [self attributesSection2];
    [self attributesSection3];
}

//返回UICollectionView的大小
- (CGSize)collectionViewContentSize {
    if(self.attributesArray.count == 0)
    {
        return CGSizeZero;
    }
    UICollectionViewLayoutAttributes * atts = [self.attributesArray lastObject];
    CGSize  size = CGSizeMake(UI_width, CGRectGetMaxY(atts.frame)+10);
    return size;
}

/**
 返回cell的所有布局属性
 */
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return [self.attributesArray filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes *evaluatedObject, NSDictionary *bindings){
        return CGRectIntersectsRect(rect, [evaluatedObject frame]);
    }]];
}

//返回值控制指定分区的页眉页脚控件的大小和位置等布局信息
-(UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:kind withIndexPath:indexPath];
    return attributes;
}
//返回值控制指定分区的装饰控件的大小和位置等布局信息
-(UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)decorationViewKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [[UICollectionViewLayoutAttributes alloc] init];
    return attributes;
}


//返回控制指定NSIndexthPath对应的单元格的大小和位置等布局信息
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.attributesArray[indexPath.item];
}


//广告滚动图
- (void)attributesSection0 {
    for (NSInteger i = 0; i < [[self collectionView] numberOfItemsInSection:0]; i ++) {
        NSIndexPath * indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes * attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attrs.frame = CGRectMake(0, 0, UI_width, 130);
        [self.attributesArray addObject:attrs];
    }
}

//新品上市
- (void)attributesSection1 {
    UICollectionViewLayoutAttributes * lastAttrs = [self.attributesArray lastObject];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:1];
    UICollectionViewLayoutAttributes * attrtubes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
    attrtubes.frame = CGRectMake(0, CGRectGetMaxY(lastAttrs.frame), UI_width, sectionHeaderHight);
    [self.attributesArray addObject:attrtubes];
    
    for (NSInteger i = 0; i < [self.collectionView numberOfItemsInSection:1]; i ++) {
        NSIndexPath * indexPaths = [NSIndexPath indexPathForItem:i inSection:1];
        UICollectionViewLayoutAttributes * attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPaths];
        attrs.frame = CGRectMake(0, CGRectGetMaxY(((UICollectionViewLayoutAttributes *)[self.attributesArray lastObject]).frame), UI_width, (UI_width-20)/4);
        [self.attributesArray addObject:attrs];
    }
}

//热卖
- (void)attributesSection2 {
    UICollectionViewLayoutAttributes * lastAttrs = [self.attributesArray lastObject];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:2];
    UICollectionViewLayoutAttributes * attrtubes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
    attrtubes.frame = CGRectMake(0, CGRectGetMaxY(lastAttrs.frame), UI_width, sectionHeaderHight);
    [self.attributesArray addObject:attrtubes];
    
    for (NSInteger i = 0; i < [self.collectionView numberOfItemsInSection:2]; i ++) {
        NSIndexPath * indexPaths = [NSIndexPath indexPathForItem:i inSection:2];
        UICollectionViewLayoutAttributes * attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPaths];
        attrs.frame = CGRectMake(0, CGRectGetMaxY(((UICollectionViewLayoutAttributes *)[self.attributesArray lastObject]).frame)+2, UI_width, 100);
        [self.attributesArray addObject:attrs];
    }
}

//更多产品
- (void)attributesSection3 {
    UICollectionViewLayoutAttributes * lastAttrs = [self.attributesArray lastObject];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:3];
    UICollectionViewLayoutAttributes * attrtubes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
    attrtubes.frame = CGRectMake(0, CGRectGetMaxY(lastAttrs.frame), UI_width, sectionHeaderHight);
    [self.attributesArray addObject:attrtubes];
    
    for (NSInteger i = 0; i < [self.collectionView numberOfItemsInSection:3]; i ++) {
        NSIndexPath * indexPaths = [NSIndexPath indexPathForItem:i inSection:3];
        UICollectionViewLayoutAttributes * attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPaths];
        attrs.frame = CGRectMake(i%2*(UI_width/2), CGRectGetMaxY(lastAttrs.frame)+35+i/2*(200+2), (UI_width-2)/2, 200);
        [self.attributesArray addObject:attrs];
    }

}

@end
