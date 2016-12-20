//
//  RecommendedController.m
//  极简壁纸
//
//  Created by 璠 王 on 2016/12/17.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import "RecommendedController.h"
#import "WallpaperModel.h"
#import "TwoCell.h"
#import "ThreeCell.h"
#import "NetManager.h"

@interface RecommendedController ()
@property(nonatomic, copy) NSMutableArray<WallpaperDataModel *> *dataList;
@property(nonatomic, assign) NSInteger page;
@end

@implementation RecommendedController

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
    [self.tableView registerClass:[TwoCell class] forCellReuseIdentifier:@"TwoCell"];
    [self.tableView registerClass:[ThreeCell class] forCellReuseIdentifier:@"ThreeCell"];
    
    
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 1)];
    self.tableView.sectionHeaderHeight = 5;
    self.tableView.sectionFooterHeight = 5;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 5)];
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [NetManager getWallpaperModelWithTitle:TitleRecommended andPage:1 andLimit:30 completionHandler:^(WallpaperModel *model, NSError *error) {
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
        [NetManager getWallpaperModelWithTitle:TitleRecommended andPage:self.page + 1 andLimit:30 completionHandler:^(WallpaperModel *model, NSError *error) {
            if (!error) {
                //********新建一个可变数组，把model.data保存下来，然后调用方法去掉广告
                NSMutableArray *array = [NSMutableArray arrayWithArray:model.data];
                array = [self removeAds:array];
                //*************
                [self.dataList addObjectsFromArray:array];
                self.page++;
                [self.tableView reloadData];
            }
            if (model.data.count < 30) {
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
    return [self tableView:tableView cellForRowAtIndexPath:indexPath model:model];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WallpaperDataModel *model = self.dataList[indexPath.section];
    switch (model.pictures.count) {
        case 2:
            return kScreenWidth * 344 / 375.0;
        //case 3:
            default:
            return kScreenWidth * 449 / 375.0;
//        case 5:
//            return kScreenWidth * 338 / 375.0;
//        case 6:
//            return kScreenWidth * 504 / 375.0;
//        default: // 9
//            return kScreenWidth * 500 / 375.0;
    }
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
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath model:(WallpaperDataModel *)model {
    NSInteger numberOfPics = model.pictures.count;
    switch (numberOfPics) {
        case 2:
        {
            TwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TwoCell" forIndexPath:indexPath];
            [cell.firstIV setImageURL:model.pictures[0].thumb.url.wf_url];
            [cell.secondIV setImageURL:model.pictures[1].thumb.url.wf_url];
            return cell;
        }
            
        //case 3:
        default:
        {
            ThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThreeCell" forIndexPath:indexPath];
            [cell.firstIV setImageURL:model.pictures[0].thumb.url.wf_url];
            [cell.secondIV setImageURL:model.pictures[1].thumb.url.wf_url];
            [cell.thirdIV setImageURL:model.pictures[2].thumb.url.wf_url];
            return cell;
        }
            
//        case 5:
//            <#statements#>
//            break;
//        case 6:
//            <#statements#>
//            break;
//        case 9:
//            <#statements#>
//            break;
    }
}

@end
