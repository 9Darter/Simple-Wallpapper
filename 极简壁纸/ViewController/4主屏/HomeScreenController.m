//
//  HomeScreenController.m
//  极简壁纸
//
//  Created by 璠 王 on 2016/12/17.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import "HomeScreenController.h"
#import "HomeScreenLayout.h"
#import "NetManager.h"
#import "HomeScreenCell.h"

@interface HomeScreenController ()
@property(nonatomic, copy) NSMutableArray<NSArray<LockScreenDataModel *> *> *dataList;
@property(nonatomic, assign) NSInteger page;
@end

@implementation HomeScreenController

#pragma mark - 重写初始化方法
-(instancetype)init {
    if (self = [super initWithCollectionViewLayout:[HomeScreenLayout new]]) {
        
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
    [self.collectionView registerClass:[HomeScreenCell class] forCellWithReuseIdentifier:@"HomeScreenCell"];
    //刷新及网络请求
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [NetManager getLockScreenModelWithSpecial:1 andPage:1 andLimit:kLimit completionHandler:^(LockScreenModel *model, NSError *error) {
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
        [NetManager getLockScreenModelWithSpecial:1 andPage:self.page + 1 andLimit:kLimit completionHandler:^(LockScreenModel *model, NSError *error) {
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

#pragma mark - Delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataList.count * 2;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeScreenCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"HomeScreenCell" forIndexPath:indexPath];
    LockScreenDataModel *model = self.dataList[indexPath.row / 2][indexPath.row % 2];
    [cell.iconIV setImageURL:model.thumb.url.wf_url];
    
    //*****给图片上面加一个额外的图层，显示锁屏图案*****
    UIImageView *homeScreenView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"page_cell_style_preview_home_cn_200x355_"]];
    homeScreenView.contentMode = UIViewContentModeScaleAspectFit;
    [cell.iconIV addSubview:homeScreenView];
    [homeScreenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    //****************
    
    return cell;
}

@end
