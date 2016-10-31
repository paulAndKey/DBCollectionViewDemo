//
//  Card3DCollectionViewFlowLayout.h
//  DBCollectionView
//
//  Created by 董宝龙 on 2016/10/27.
//  Copyright © 2016年 dbl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DBCollectionViewFlowDelegate <NSObject>

- (void)scrollToViewIndex:(NSInteger)index;

@end

@interface Card3DCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic , weak)id<DBCollectionViewFlowDelegate>delegate;



@end
