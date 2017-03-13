//
//  CollectionCardViewCell.m
//
//  Created by ChinaChong on 2017/3/13.
//  Copyright © 2017年 ChinaChong. All rights reserved.
//

#import "CollectionCardViewCell.h"
#import "Header.h"

@interface CollectionCardViewCell ()

@property (nonatomic,strong) UIImageView *cardView;

@end

@implementation CollectionCardViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _cardView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:_cardView];
        
        CGFloat cellWidth  = ITEM_WIDTH  * SCALE;
        CGFloat cellheight = ITEM_HEIGHT * SCALE;
        [_cardView setFrame:CGRectMake(0, 0, cellWidth, cellheight)];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
   
}

- (void)setCellImage:(UIImage *)image {
    if (image && ![image isKindOfClass:[NSNull class]]) {
        _cardView.image = image;
    }
}

@end
