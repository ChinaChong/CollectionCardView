//
//  ViewController.m
//
//  Created by ChinaChong on 2017/3/13.
//  Copyright © 2017年 ChinaChong. All rights reserved.
//

#import "ViewController.h"
#import "CollectionCardView.h"
#import "Header.h"

@interface ViewController ()<CardViewDelegate>

@property (nonatomic,strong) CollectionCardView *cardScrollView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cardScrollView = [[CollectionCardView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    self.cardScrollView.delegate = self;
    [self.cardScrollView setItmeArray:self.dataArray hasData:NO complete:nil];
    [self.cardScrollView setCurrentCardIndex:0];
    [self.view addSubview:self.cardScrollView];
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
        for (int i = 0; i < 14; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"timg-%d",i]];
            [_dataArray addObject:image];
        }
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
