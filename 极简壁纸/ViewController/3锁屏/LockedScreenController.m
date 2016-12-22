//
//  LockedScreenController.m
//  极简壁纸
//
//  Created by 璠 王 on 2016/12/17.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import "LockedScreenController.h"
#import "LockScreenLayout.h"
#import "NetManager.h"
#import "LockScreenCell.h"

@interface LockedScreenController ()
@property(nonatomic, copy) NSMutableArray<WallpaperDataModel *> *dataList;
@property(nonatomic, assign) NSInteger page;
@end

@implementation LockedScreenController

#pragma mark - 重写初始化方法
-(instancetype)init {
    if (self = [super initWithCollectionViewLayout:[LockScreenLayout new]]) {
        
    }
    return self;
}
#pragma mark - Lazy
-(NSMutableArray<WallpaperDataModel *> *)dataList {
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
    [self.collectionView registerClass:[LockScreenCell class] forCellWithReuseIdentifier:@"LockScreenCell"];
    //刷新及网络请求
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [NetManager getWallpaperModelWithTitle:TitleLockedScreen andPage:1 andLimit:25 completionHandler:^(WallpaperModel *model, NSError *error) {
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
        [NetManager getWallpaperModelWithTitle:TitleLockedScreen andPage:self.page + 1 andLimit:25 completionHandler:^(WallpaperModel *model, NSError *error) {
            if (!error) {
                [self.dataList addObjectsFromArray:model.data];
                [self.collectionView reloadData];
                self.page++;
            }
            if (model.data.count < 30) {
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

#pragma mark - Delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataList.count;
}
//-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    LockScreenCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"LockScreenCell" forIndexPath:indexPath];
//    WallpaperDataModel *model = self.dataList[indexPath.row];
//    cell.iconIV setImageURL:model.pictures
//    
//}
@end
