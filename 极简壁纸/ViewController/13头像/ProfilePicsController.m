//
//  ProfilePicsController.m
//  极简壁纸
//
//  Created by 璠 王 on 2016/12/17.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import "ProfilePicsController.h"
#import "ProfilePicCell.h"
#import "NetManager.h"
#import "ProfilePicsLayout.h"

#import "PicController.h"

@interface ProfilePicsController ()
@property(nonatomic, copy) NSMutableArray<NSArray<LockScreenDataModel *> *> *dataList;
@property(nonatomic, assign) NSInteger page;
@end

@implementation ProfilePicsController

#pragma mark - 重写初始化方法
-(instancetype)init {
    if (self = [super initWithCollectionViewLayout:[ProfilePicsLayout new]]) {
        
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
    self.collectionView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:235 / 255.0 blue:235 / 255.0 alpha:1];
    //注册cell
    [self.collectionView registerClass:[ProfilePicCell class] forCellWithReuseIdentifier:@"ProfilePicCell"];
    //刷新及网络请求
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [NetManager getLockScreenModelWithSpecial:13 andPage:1 andLimit:kLimit completionHandler:^(LockScreenModel *model, NSError *error) {
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
        [NetManager getLockScreenModelWithSpecial:13 andPage:self.page + 1 andLimit:kLimit completionHandler:^(LockScreenModel *model, NSError *error) {
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"13头像"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"13头像"];
}

#pragma mark - Delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataList.count * 2;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProfilePicCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ProfilePicCell" forIndexPath:indexPath];
    LockScreenDataModel *model = self.dataList[indexPath.row / 2][indexPath.row % 2];
    [cell.iconIV setImageURL:model.thumb.url.wf_url];
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PicController *vc = [PicController new];
    vc.lockDataList = self.dataList;
    vc.page = self.page;
    vc.picTitle = TitleProfilePics;
    LockScreenDataModel *model = self.dataList[indexPath.row / 2][indexPath.row % 2];
    vc.fn = [model.fn integerValue];
    vc.special = 1;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

@end
