//
//  CollectionCardViewLayout.m
//
//  Created by ChinaChong on 2017/3/13.
//  Copyright © 2017年 ChinaChong. All rights reserved.
//

#import "CollectionCardViewLayout.h"
#import "Header.h"

//放大后的大小
#define spacing ([UIScreen mainScreen].bounds.size.width - ITEM_WIDTH) * 0.5 + ITEM_WIDTH * (1-SCALE) * 0.5
#define item_spacing 15 * WindowZoomScale_6 + ITEM_WIDTH * (1 - SCALE) * 0.5
#define Inset ([UIScreen mainScreen].bounds.size.width - ITEM_WIDTH) * 0.5)
@implementation CollectionCardViewLayout

- (instancetype) init {
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(ITEM_WIDTH * SCALE, ITEM_HEIGHT * SCALE);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        // 设置间距
        self.minimumLineSpacing = item_spacing;
        // 设置内边距
        self.sectionInset = UIEdgeInsetsMake(0, spacing, 0, spacing);
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds {
    return YES;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    // 获得super已经计算好的布局属性
    NSArray *attributes = [[NSArray alloc] initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
    
    // 以画布的坐标系为参考计算collectionView最中心点的x值
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    // 在原有布局属性的基础上，进行微调
    for (UICollectionViewLayoutAttributes *attrs in attributes) {
        // cell的中心点x 和 collectionView最中心点的x值 的间距（都是以画布坐标系为参考）
        CGFloat delta = ABS(attrs.center.x - centerX);
        CGFloat x = ITEM_WIDTH/ (1 - SCALE);
        CGFloat scale = 1/SCALE - delta / x;
        
        // 设置缩放比例
        attrs.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    return  attributes;
    
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGFloat offsetAdjustment = MAXFLOAT;
    
    // 以画布的坐标系为参考计算collectionView最中心点的x值
    CGFloat horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);
    
    // proposed:本应该停在的位置
    CGRect proposedRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray *array = [super layoutAttributesForElementsInRect:proposedRect];
    
    for (UICollectionViewLayoutAttributes* layoutAttributes in array) {
        CGFloat itemHorizontalCenter = layoutAttributes.center.x;
        if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offsetAdjustment)) {
            offsetAdjustment = itemHorizontalCenter - horizontalCenter;
        }
    }
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}


@end
