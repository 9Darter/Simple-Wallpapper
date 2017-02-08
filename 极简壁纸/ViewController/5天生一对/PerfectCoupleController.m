//
//  PerfectCoupleController.m
//  极简壁纸
//
//  Created by 璠 王 on 2016/12/17.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import "PerfectCoupleController.h"
#import "WallpaperModel.h"
#import "PerfectCoupleCell.h"
#import "NetManager.h"

#import "PicController.h"

@interface PerfectCoupleController ()
@property(nonatomic, copy) NSMutableArray<WallpaperDataModel *> *dataList;
@property(nonatomic, assign) NSInteger page;
@end

@implementation PerfectCoupleController

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
    [self.tableView registerClass:[PerfectCoupleCell class] forCellReuseIdentifier:@"PerfectCoupleCell"];
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 1)];
    self.tableView.sectionHeaderHeight = 5;
    self.tableView.sectionFooterHeight = 5;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 5)];
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [NetManager getWallpaperModelWithTitle:TitlePerfectCouple andPage:1 andLimit:kLimit completionHandler:^(WallpaperModel *model, NSError *error) {
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
        [NetManager getWallpaperModelWithTitle:TitlePerfectCouple andPage:self.page + 1 andLimit:kLimit completionHandler:^(WallpaperModel *model, NSError *error) {
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
-(BOOL)prefersStatusBarHidden {
    return NO;
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
    return kScreenWidth * 344 / 375.0;
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
//点击图片后的正向传值和跳转
-(void)creatVcOfPicControllerWithPictureIndex:(NSInteger)index ofModel:(WallpaperDataModel *)model{
    PicController *vc = [PicController new];
    vc.dataList = self.dataList;
    vc.page = self.page;
    vc.picTitle = TitlePerfectCouple;
    vc.fn = model.pictures[index].fn;
    vc.isSpecial = NO;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath model:(WallpaperDataModel *)model {
    PerfectCoupleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PerfectCoupleCell" forIndexPath:indexPath];
    [cell.firstIV setImageURL:model.pictures[0].thumb.url.wf_url];
    [cell.secondIV setImageURL:model.pictures[1].thumb.url.wf_url];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //给每个imageView单独设置手势触发的block
    [cell setPushBlock1:^(PerfectCoupleCell *cell) {
        //封装了一个方法，要不然这里的代码重复率太高
        [self creatVcOfPicControllerWithPictureIndex:0 ofModel:model];
    }];
    [cell setPushBlock2:^(PerfectCoupleCell *cell) {
        [self creatVcOfPicControllerWithPictureIndex:1 ofModel:model];
    }];
    return cell;
    
}
@end
