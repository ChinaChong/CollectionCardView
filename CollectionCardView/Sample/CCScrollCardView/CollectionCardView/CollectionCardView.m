//
//  CollectionCardView.m
//
//  Created by ChinaChong on 2017/3/13.
//  Copyright © 2017年 ChinaChong. All rights reserved.
//

#import "CollectionCardView.h"
#import "CollectionCardViewCell.h"
#import "CollectionCardViewLayout.h"
#import "Header.h"

#define ScrollViewWidth (int)(320 * WindowZoomScale_6)

@interface CollectionCardView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collecionView;
@property (nonatomic,strong) NSMutableArray   *dataArray;

@end

static NSInteger preloadAmount = 5; // 预加载页数(在滑动到最后preloadAmount个的时候,开始加载下一页的数据)

@implementation CollectionCardView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.collecionView registerClass:[CollectionCardViewCell class] forCellWithReuseIdentifier:@"CollectionCardViewCell"];
        self.collecionView.dataSource = self;
        self.collecionView.delegate   = self;
        [self addSubview:self.collecionView];
        self.collecionView.backgroundColor = HexColor(0x666666);
        return self;
    }
    return nil;
}

// MARK：设置数据
- (void)setItmeArray:(NSMutableArray *)itmeArray hasData:(BOOL)hasData complete:(void(^)())handler {
    self.dataArray = [NSMutableArray arrayWithArray:itmeArray];
    // 是否需要预加载下一页
    if (hasData) {
        UIImage *image = [[UIImage alloc] init];
        [self.dataArray addObject:image];
    }
    [self.collecionView reloadData];
    if (handler) handler();
}

// MARK：定位页码
- (void)setCurrentCardIndex:(NSInteger)index {
    // 滚动页码的方法
    [self.collecionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSIndexPath *index = [self.collecionView indexPathForItemAtPoint:CGPointMake(scrollView.contentOffset.x + SCREENWIDTH / 2, (SCREENHEIGHT + 64) / 2)];
    if (_delegate && [_delegate respondsToSelector:@selector(scrolIndex:)]) {
        [self.delegate scrolIndex:index.item];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionCardViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCardViewCell" forIndexPath:indexPath];
    [cell setCellImage:self.dataArray[indexPath.item]];
    
    if ((self.dataArray.count - indexPath.row) < preloadAmount && _isLoading == NO) {
        if (_delegate && [_delegate respondsToSelector:@selector(scrollerReloadData)]) {
            [self.delegate scrollerReloadData];
        }
    }
    return cell;
}

- (UICollectionView *)collecionView {
    if (_collecionView == nil) {
        CollectionCardViewLayout *flowLayout = [[CollectionCardViewLayout alloc] init];
        _collecionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) collectionViewLayout:flowLayout];
        _collecionView.backgroundColor = [UIColor orangeColor];
        _collecionView.showsHorizontalScrollIndicator = NO;
        _collecionView.decelerationRate = 0.1;
    }
    return _collecionView;
}


@end
