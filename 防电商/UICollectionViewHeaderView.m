//
//  UICollectionViewHeaderView.m
//  DBCollectionView
//
//  Created by 董宝龙 on 2016/10/26.
//  Copyright © 2016年 dbl. All rights reserved.
//

#import "UICollectionViewHeaderView.h"

@implementation UICollectionViewHeaderView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 1.5, CGRectGetHeight(self.frame)-20)];
        lineView.backgroundColor = [UIColor grayColor];
        [self addSubview:lineView];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lineView.frame)+5, CGRectGetMinY(lineView.frame), 100, CGRectGetHeight(lineView.frame))];
        label.text = title;
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:14];
        [self addSubview:label];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
