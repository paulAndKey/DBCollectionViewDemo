//
//  NewCollectionViewCell.m
//  DBCollectionView
//
//  Created by 董宝龙 on 2016/10/26.
//  Copyright © 2016年 dbl. All rights reserved.
//

#import "NewCollectionViewCell.h"
#define UI_width [UIScreen mainScreen].bounds.size.width
#define UI_height [UIScreen mainScreen].bounds.size.height

@interface NewCollectionViewCell ()

@property (nonatomic , strong) UIScrollView * scrollView;

@end

@implementation NewCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UI_width, (UI_width-20)/4)];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.scrollView];
    }
    return self;
}

- (void)addValueCellWithArray:(NSArray *)array {
    for (NSInteger i = 0; i < array.count; i ++) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10+((UI_width-20)/4+10)*i, 0, (UI_width-20)/4, (UI_width-20)/4)];
        imageView.backgroundColor = [UIColor redColor];
        [self.scrollView addSubview:imageView];
        self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(imageView.frame)+10, 0);
    }
}

@end
