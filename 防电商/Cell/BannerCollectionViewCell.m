//
//  BannerCollectionViewCell.m
//  DBCollectionView
//
//  Created by 董宝龙 on 2016/10/26.
//  Copyright © 2016年 dbl. All rights reserved.
//
#define UI_width [UIScreen mainScreen].bounds.size.width
#define UI_height [UIScreen mainScreen].bounds.size.height
#define randoms(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#import "BannerCollectionViewCell.h"
#import "CycleScrollView.h"
@interface BannerCollectionViewCell ()

@property (nonatomic , strong) CycleScrollView * cycleScrollView;

@end

@implementation BannerCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.cycleScrollView = [[CycleScrollView alloc]initWithFrame:CGRectMake(0, 0, UI_width, 130) animationDuration:3.0];
        NSArray * array = @[@"0",@"1",@"2",@"3"];
        NSMutableArray * viewArray = [NSMutableArray new];
        for (NSInteger i = 0; i < array.count; i++) {
            int R = (arc4random() % 256) ;
            int G = (arc4random() % 256) ;
            int B = (arc4random() % 256) ;
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UI_width, 130)];
            imageView.backgroundColor = randoms(R, G, B, 255.0);
            [viewArray addObject:imageView];
        }
        self.cycleScrollView.backgroundColor = [UIColor whiteColor];
        self.cycleScrollView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
            return viewArray[pageIndex];
        };
        self.cycleScrollView.totalPagesCount = ^NSInteger(void){
            return viewArray.count;
        };
        self.cycleScrollView.TapActionBlock = ^(NSInteger pageIndex){
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"ACTIVITYCLICK" object:[NSString stringWithFormat:@"%i",(int)pageIndex]];
            
        };
        [self addSubview:self.cycleScrollView];
        [self.cycleScrollView setTapActionBlock:^(NSInteger index) {
            //点击了那个banner
            NSLog(@"%ld",index);
        }];
    }
    return self;
}

@end
