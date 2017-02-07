//
//  LatestController.m
//  极简壁纸
//
//  Created by 璠 王 on 2016/12/17.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import "LatestController.h"
#import "WallpaperModel.h"
#import "TwoCell.h"
#import "ThreeCell.h"
#import "FiveCell.h"
#import "NetManager.h"
#import "SixCell.h"
#import "NineCell.h"

#import "PicController.h"

@interface LatestController ()
@property(nonatomic, copy) NSMutableArray<WallpaperDataModel *> *dataList;
@property(nonatomic, assign) NSInteger page;
@end

@implementation LatestController

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
    [self.tableView registerClass:[FiveCell class] forCellReuseIdentifier:@"FiveCell"];
    [self.tableView registerClass:[SixCell class] forCellReuseIdentifier:@"SixCell"];
    [self.tableView registerClass:[NineCell class] forCellReuseIdentifier:@"NineCell"];
    
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 1)];
    self.tableView.sectionHeaderHeight = 5;
    self.tableView.sectionFooterHeight = 5;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 5)];
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [NetManager getWallpaperModelWithTitle:TitleLatest andPage:1 andLimit:kLimit completionHandler:^(WallpaperModel *model, NSError *error) {
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
        [NetManager getWallpaperModelWithTitle:TitleLatest andPage:self.page + 1 andLimit:kLimit completionHandler:^(WallpaperModel *model, NSError *error) {
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
-(void)viewWillAppear:(BOOL)animated {
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
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
        case 3:
            return kScreenWidth * 449 / 375.0;
        case 5:
            return kScreenWidth * 338 / 375.0;
        case 6:
            return kScreenWidth * 504 / 375.0;
        default: //case: 9
            return kScreenWidth * 500 / 375.0;
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
//点击图片后的正向传值和跳转
-(void)creatVcOfPicControllerWithPictureIndex:(NSInteger)index ofModel:(WallpaperDataModel *)model{
    PicController *vc = [PicController new];
    vc.dataList = self.dataList;
    vc.page = self.page;
    vc.picTitle = TitleLatest;
    vc.fn = model.pictures[index].fn;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath model:(WallpaperDataModel *)model {
    NSInteger numberOfPics = model.pictures.count;
    switch (numberOfPics) {
        case 2:
        {
            TwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TwoCell" forIndexPath:indexPath];
            [cell.firstIV setImageURL:model.pictures[0].thumb.url.wf_url];
            [cell.secondIV setImageURL:model.pictures[1].thumb.url.wf_url];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //给每个imageView单独设置手势触发的block
            [cell setPushBlock1:^(TwoCell *cell) {
                //封装了一个方法，要不然这里的代码重复率太高
                [self creatVcOfPicControllerWithPictureIndex:0 ofModel:model];
            }];
            [cell setPushBlock2:^(TwoCell *cell) {
                [self creatVcOfPicControllerWithPictureIndex:1 ofModel:model];
            }];
            return cell;
        }
            
        case 3: case 4: //一般不会出现case 4
        {
            ThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThreeCell" forIndexPath:indexPath];
            [cell.firstIV setImageURL:model.pictures[0].thumb.url.wf_url];
            [cell.secondIV setImageURL:model.pictures[1].thumb.url.wf_url];
            [cell.thirdIV setImageURL:model.pictures[2].thumb.url.wf_url];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //给每个imageView单独设置手势触发的block
            [cell setPushBlock1:^(ThreeCell *cell) {
                //封装了一个方法，要不然这里的代码重复率太高
                [self creatVcOfPicControllerWithPictureIndex:0 ofModel:model];
            }];
            [cell setPushBlock2:^(ThreeCell *cell) {
                [self creatVcOfPicControllerWithPictureIndex:1 ofModel:model];
            }];
            [cell setPushBlock3:^(ThreeCell *cell) {
                [self creatVcOfPicControllerWithPictureIndex:2 ofModel:model];
            }];
            return cell;
        }
            
        case 5:
            
        {
            FiveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FiveCell" forIndexPath:indexPath];
            [cell.firstIV setImageURL:model.pictures[0].thumb.url.wf_url];
            [cell.secondIV setImageURL:model.pictures[1].thumb.url.wf_url];
            [cell.thirdIV setImageURL:model.pictures[2].thumb.url.wf_url];
            [cell.fourthIV setImageURL:model.pictures[3].thumb.url.wf_url];
            [cell.fifthIV setImageURL:model.pictures[4].thumb.url.wf_url];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //给每个imageView单独设置手势触发的block
            [cell setPushBlock1:^(FiveCell *cell) {
                //封装了一个方法，要不然这里的代码重复率太高
                [self creatVcOfPicControllerWithPictureIndex:0 ofModel:model];
            }];
            [cell setPushBlock2:^(FiveCell *cell) {
                [self creatVcOfPicControllerWithPictureIndex:1 ofModel:model];
            }];
            [cell setPushBlock3:^(FiveCell *cell) {
                [self creatVcOfPicControllerWithPictureIndex:2 ofModel:model];
            }];
            [cell setPushBlock4:^(FiveCell *cell) {
                [self creatVcOfPicControllerWithPictureIndex:3 ofModel:model];
            }];
            [cell setPushBlock5:^(FiveCell *cell) {
                [self creatVcOfPicControllerWithPictureIndex:4 ofModel:model];
            }];
            return cell;
        }
            
        case 6: case 7: case 8:// case 7、8也为特殊情况
        {
            SixCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SixCell" forIndexPath:indexPath];
            [cell.firstIV setImageURL:model.pictures[0].thumb.url.wf_url];
            [cell.secondIV setImageURL:model.pictures[1].thumb.url.wf_url];
            [cell.thirdIV setImageURL:model.pictures[2].thumb.url.wf_url];
            [cell.fourthIV setImageURL:model.pictures[3].thumb.url.wf_url];
            [cell.fifthIV setImageURL:model.pictures[4].thumb.url.wf_url];
            [cell.sixIV setImageURL:model.pictures[5].thumb.url.wf_url];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //给每个imageView单独设置手势触发的block
            [cell setPushBlock1:^(SixCell *cell) {
                //封装了一个方法，要不然这里的代码重复率太高
                [self creatVcOfPicControllerWithPictureIndex:0 ofModel:model];
            }];
            [cell setPushBlock2:^(SixCell *cell) {
                [self creatVcOfPicControllerWithPictureIndex:1 ofModel:model];
            }];
            [cell setPushBlock3:^(SixCell *cell) {
                [self creatVcOfPicControllerWithPictureIndex:2 ofModel:model];
            }];
            [cell setPushBlock4:^(SixCell *cell) {
                [self creatVcOfPicControllerWithPictureIndex:3 ofModel:model];
            }];
            [cell setPushBlock5:^(SixCell *cell) {
                [self creatVcOfPicControllerWithPictureIndex:4 ofModel:model];
            }];
            [cell setPushBlock6:^(SixCell *cell) {
                [self creatVcOfPicControllerWithPictureIndex:5 ofModel:model];
            }];
            return cell;
        }
            
        default: //case 9:
        {
            NineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NineCell" forIndexPath:indexPath];
            [cell.firstIV setImageURL:model.pictures[0].thumb.url.wf_url];
            [cell.secondIV setImageURL:model.pictures[1].thumb.url.wf_url];
            [cell.thirdIV setImageURL:model.pictures[2].thumb.url.wf_url];
            [cell.fourthIV setImageURL:model.pictures[3].thumb.url.wf_url];
            [cell.fifthIV setImageURL:model.pictures[4].thumb.url.wf_url];
            [cell.sixIV setImageURL:model.pictures[5].thumb.url.wf_url];
            [cell.sevenIV setImageURL:model.pictures[6].thumb.url.wf_url];
            [cell.eightIV setImageURL:model.pictures[7].thumb.url.wf_url];
            [cell.nineIV setImageURL:model.pictures[8].thumb.url.wf_url];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //给每个imageView单独设置手势触发的block
            [cell setPushBlock1:^(NineCell *cell) {
                //封装了一个方法，要不然这里的代码重复率太高
                [self creatVcOfPicControllerWithPictureIndex:0 ofModel:model];
            }];
            [cell setPushBlock2:^(NineCell *cell) {
                [self creatVcOfPicControllerWithPictureIndex:1 ofModel:model];
            }];
            [cell setPushBlock3:^(NineCell *cell) {
                [self creatVcOfPicControllerWithPictureIndex:2 ofModel:model];
            }];
            [cell setPushBlock4:^(NineCell *cell) {
                [self creatVcOfPicControllerWithPictureIndex:3 ofModel:model];
            }];
            [cell setPushBlock5:^(NineCell *cell) {
                [self creatVcOfPicControllerWithPictureIndex:4 ofModel:model];
            }];
            [cell setPushBlock6:^(NineCell *cell) {
                [self creatVcOfPicControllerWithPictureIndex:5 ofModel:model];
            }];
            [cell setPushBlock7:^(NineCell *cell) {
                [self creatVcOfPicControllerWithPictureIndex:6 ofModel:model];
            }];
            [cell setPushBlock8:^(NineCell *cell) {
                [self creatVcOfPicControllerWithPictureIndex:7 ofModel:model];
            }];
            [cell setPushBlock9:^(NineCell *cell) {
                [self creatVcOfPicControllerWithPictureIndex:8 ofModel:model];
            }];
            return cell;
        }
    }
}

@end
