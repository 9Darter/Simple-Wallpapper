//
//  BoysController.m
//  极简壁纸
//
//  Created by 璠 王 on 2016/12/17.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import "BoysController.h"
#import "MostPopularLayout.h"
#import "NetManager.h"
#import "MostPopularCell.h"

#import "PicController.h"

@interface BoysController ()
@property(nonatomic, copy) NSMutableArray<NSArray<LockScreenDataModel *> *> *dataList;
@property(nonatomic, assign) NSInteger page;
@end

@implementation BoysController

#pragma mark - 重写初始化方法
-(instancetype)init {
    if (self = [super initWithCollectionViewLayout:[MostPopularLayout new]]) {
        
    }
    return self;
}
#pragma mark - Lazy
-(NSMutableArray<NSArray<LockScreenDataModel *> *> *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray new];
    }
    return _dataList;
}

#pragma mark - Life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //注册cell
    [self.collectionView registerClass:[MostPopularCell class] forCellWithReuseIdentifier:@"MostPopularCell"];
    //刷新及网络请求
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [NetManager getLockScreenModelWithSpecial:9 andPage:1 andLimit:kLimit completionHandler:^(LockScreenModel *model, NSError *error) {
            if (!error) {
                [self.dataList removeAllObjects];
                [self.dataList addObjectsFromArray:model.data];
                [self.collectionView reloadData];
                self.page = 1;
            }
            [self.collectionView.mj_header endRefreshing];
        }];
    }];
    
    [self.collectionView.mj_header beginRefreshing];
    
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [NetManager getLockScreenModelWithSpecial:9 andPage:self.page + 1 andLimit:kLimit completionHandler:^(LockScreenModel *model, NSError *error) {
            if (!error) {
                [self.dataList addObjectsFromArray:model.data];
                [self.collectionView reloadData];
                self.page++;
            }
            if (model.data.count < 1) {
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            } else {
                [self.collectionView.mj_footer endRefreshing];
            }
        }];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)prefersStatusBarHidden {
    return NO;
}

#pragma mark - Delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataList.count * 3;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MostPopularCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"MostPopularCell" forIndexPath:indexPath];
    LockScreenDataModel *model = self.dataList[indexPath.row / 3][indexPath.row % 3];
    [cell.iconIV setImageURL:model.thumb.url.wf_url];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PicController *vc = [PicController new];
    vc.lockDataList = self.dataList;
    vc.page = self.page;
    vc.picTitle = TitleBoys;
    LockScreenDataModel *model = self.dataList[indexPath.row / 3][indexPath.row % 3];
    vc.fn = [model.fn integerValue];
    vc.isSpecial = YES;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

@end
