//
//  CardCollectionViewCell.m
//  DBCollectionView
//
//  Created by 董宝龙 on 2016/10/27.
//  Copyright © 2016年 dbl. All rights reserved.
//

#import "CardCollectionViewCell.h"

@interface CardCollectionViewCell ()


@end

@implementation CardCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 180, 280)];
         self.imageView.backgroundColor = [UIColor whiteColor];
        self.imageView.layer.cornerRadius = 5.0f;
        self.imageView.layer.masksToBounds = YES;
        [self.contentView addSubview: self.imageView];
    }
    return self;
}


@end
