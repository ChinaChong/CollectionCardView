//
//  CollectionCardView.h
//
//  Created by ChinaChong on 2017/3/13.
//  Copyright © 2017年 ChinaChong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CardViewDelegate <NSObject>

@optional

// 在滑动到倒数第preloadAmount页的时候,在此代理方法开始加载下一页的数据
- (void)scrollerReloadData;

// 当前滑动到第index页
- (void)scrolIndex:(NSInteger)index;

@end

@interface CollectionCardView : UIView

@property(nonatomic,assign) BOOL isLoading;

@property (nonatomic, weak) id <CardViewDelegate> delegate;

/*
 * itmeArray : 图片数组
 * hasData   : 是否需要预加载
 */
- (void)setItmeArray:(NSMutableArray *)itmeArray hasData:(BOOL)hasData complete:(void(^)())handler;

// 强制设置当前滑动到第index页
- (void)setCurrentCardIndex:(NSInteger)index;

@end
