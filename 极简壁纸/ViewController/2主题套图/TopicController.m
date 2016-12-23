//
//  TopicController.m
//  极简壁纸
//
//  Created by 璠 王 on 2016/12/17.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import "TopicController.h"
#import "WallpaperModel.h"
#import "TopicCell.h"
#import "NetManager.h"

@interface TopicController ()
@property(nonatomic, copy) NSMutableArray<WallpaperDataModel *> *dataList;
@property(nonatomic, assign) NSInteger page;
@end

@implementation TopicController

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
    //注册cell
    [self.tableView registerClass:[TopicCell class] forCellReuseIdentifier:@"TopicCell"];
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 1)];
    self.tableView.sectionHeaderHeight = 5;
    self.tableView.sectionFooterHeight = 5;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 5)];
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [NetManager getWallpaperModelWithTitle:TitleTopic andPage:1 andLimit:kLimit completionHandler:^(WallpaperModel *model, NSError *error) {
            if (!error) {
                [self.dataList removeAllObjects];
                //********新建一个可变数组，把model.data保存下来，然后调用方法去掉广告
                NSMutableArray *array = [NSMutableArray arrayWithArray:model.data];
                array = [self removeAds:array];
                //********
                [self.dataList addObjectsFromArray:array];
                self.page = 1;
                [self.tableView reloadData];
            }
            [self.tableView.mj_header endRefreshing];
        }];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [NetManager getWallpaperModelWithTitle:TitleTopic andPage:self.page + 1 andLimit:kLimit completionHandler:^(WallpaperModel *model, NSError *error) {
            if (!error) {
                //********新建一个可变数组，把model.data保存下来，然后调用方法去掉广告
                NSMutableArray *array = [NSMutableArray arrayWithArray:model.data];
                array = [self removeAds:array];
                //*************
                [self.dataList addObjectsFromArray:array];
                self.page++;
                [self.tableView reloadData];
            }
            if (model.data.count < 1) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            } else {
                [self.tableView.mj_footer endRefreshing];
            }
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataList.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WallpaperDataModel *model = self.dataList[indexPath.section];
    return [self tableView:tableView cellForRowAtIndexPath:indexPath model:model]; //调用本类方法，给每个cell赋值
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kScreenWidth * 382 / 375.0;
}

#pragma mark - Methods
-(NSMutableArray *)removeAds:(NSMutableArray *)dataList {
    NSMutableArray *tmpArr = [NSMutableArray new];
    for (WallpaperDataModel *model in dataList) {
        if (model.pictures.count != 0) {
            [tmpArr addObject:model];
        }
    }
    return tmpArr;
}
//该方法比代理方法多加了一个参数model，在此方法中给cell赋值
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath model:(WallpaperDataModel *)model {
    TopicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopicCell" forIndexPath:indexPath];
    [cell.firstIV setImageURL:model.pictures[0].thumb.url.wf_url];
    [cell.secondIV setImageURL:model.pictures[1].thumb.url.wf_url];
    cell.freeLb.text = @"免费";
    [cell.downloadBtn setTitle:@"一键下载" forState:UIControlStateNormal];
    //*****给图片上面加一个额外的图层，显示锁屏图案和图标*****
    UIImageView *lockScreenView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"page_cell_style_preview_lock_cn_200x355_"]];
    lockScreenView.contentMode = UIViewContentModeScaleAspectFit;
    UIImageView *homeScreenView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"page_cell_style_preview_home_cn_200x355_"]];
    homeScreenView.contentMode = UIViewContentModeScaleAspectFit;
    [cell.firstIV addSubview:lockScreenView];
    [lockScreenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    [cell.secondIV addSubview:homeScreenView];
    [homeScreenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    //****************
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
