//
//  Card3DCollectionViewFlowLayout.m
//  DBCollectionView
//
//  Created by 董宝龙 on 2016/10/27.
//  Copyright © 2016年 dbl. All rights reserved.
//
#define UI_width [UIScreen mainScreen].bounds.size.width

#import "Card3DCollectionViewFlowLayout.h"
#import <math.h>
@interface Card3DCollectionViewFlowLayout ()

@end

@implementation Card3DCollectionViewFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
}

//返回可见区域
- (CGSize)collectionViewContentSize {
    return [super collectionViewContentSize];
}
//返回rect中所有元素的布局属性
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    //获取可见区域
    CGRect visibleRect = CGRectMake(self.collectionView.contentOffset.x, 0, self.collectionView.frame.size.width, self.collectionView.frame.size.height);
    
    //获得这个区域的item的布局属性
    NSArray * visibleItemArray = [super layoutAttributesForElementsInRect:visibleRect];
    
    //遍历，让靠近中心线的item放大，离开的缩小
    for (UICollectionViewLayoutAttributes * attrs in visibleItemArray) {
        //获取每个item距离可见区域左侧边框的距离  有正负之分
        CGFloat leftMargin = attrs.center.x - self.collectionView.contentOffset.x;
        //获取边框距离屏幕中心的距离 这个是固定的
        CGFloat LeftFromDistanceCenterX = self.collectionView.frame.size.width/2;
        //获取距离中心的偏移量 取绝对值
        CGFloat absOffset = fabs(LeftFromDistanceCenterX - leftMargin);
        //获取的实际的缩放比例 距离中心越多，值越小；即item的scale最小，中心的最大
        CGFloat cardScale = 1 - absOffset / LeftFromDistanceCenterX;
        //缩放
        attrs.transform3D = CATransform3DMakeScale(1+cardScale * 0.3, 1+cardScale * 0.3, 1);
        //透明度
        if (cardScale < 0.5)
        {
            attrs.alpha = 0.5;
        }
        else if (cardScale > 0.99)
        {
            attrs.alpha = 1.0;
        }
        else
        {
            attrs.alpha = cardScale;
        }
        
    }
    NSArray * attibutesArray = [[NSArray alloc] initWithArray:visibleItemArray copyItems:YES];
    return attibutesArray;
}

/**
 多次调用 只要滑出范围就会 调用
 *  当CollectionView的显示范围发生改变的时候，是否重新发生布局
 *  一旦重新刷新布局，就会重新调用
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    return YES;
}

// 重载第四个属性，item自动中心对齐
// 该方法可写可不写，主要是让滚动的item根据距离中心的值，确定哪个必须展示在中心，不会像普通的那样滚动到哪里就停到哪里
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    // ProposeContentOffset是本来应该停下的位子
    // 1. 先给一个字段存储最小的偏移量 那么默认就是无限大
    CGFloat minOffset = CGFLOAT_MAX;
    // 2. 获取到可见区域的centerX
    CGFloat horizontalCenter = proposedContentOffset.x + self.collectionView.bounds.size.width / 2;
    // 3. 拿到可见区域的rect
    CGRect visibleRec = CGRectMake(proposedContentOffset.x, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    // 4. 获取到所有可见区域内的item数组
    NSArray *visibleAttributes = [super layoutAttributesForElementsInRect:visibleRec];
    
    // 遍历数组，找到距离中心最近偏移量是多少
    for (UICollectionViewLayoutAttributes *atts in visibleAttributes)
    {
        // 可见区域内每个item对应的中心X坐标
        CGFloat itemCenterX = atts.center.x;
        // 比较是否有更小的，有的话赋值给minOffset
        if (fabs(itemCenterX - horizontalCenter) <= fabs(minOffset)) {
            minOffset = itemCenterX - horizontalCenter;
        }
    }
    // 这里需要注意的是  上面获取到的minOffset有可能是负数，那么代表左边的item还没到中心，如果确定这种情况下左边的item是距离最近的，那么需要左边的item居中，意思就是collectionView的偏移量需要比原本更小才是，例如原先是1000的偏移，但是需要展示前一个item，所以需要1000减去某个偏移量，因此不需要更改偏移的正负
    
    // 但是当propose小于0的时候或者大于contentSize（除掉左侧和右侧偏移以及单个cell宽度）  、
    // 防止当第一个或者最后一个的时候不会有居中（偏移量超过了本身的宽度），直接卡在推荐的停留位置
    CGFloat centerOffsetX = proposedContentOffset.x + minOffset;
    if (centerOffsetX < 0) {
        centerOffsetX = 0;
    }
    
    if (centerOffsetX > self.collectionView.contentSize.width -(self.sectionInset.left + self.sectionInset.right + self.itemSize.width)) {
        centerOffsetX = floor(centerOffsetX);
    }
    return CGPointMake(centerOffsetX, proposedContentOffset.y);
}

@end
