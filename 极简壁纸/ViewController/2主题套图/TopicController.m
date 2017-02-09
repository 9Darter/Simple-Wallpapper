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

#import "PicController.h"

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
//点击图片后的正向传值和跳转
-(void)creatVcOfPicControllerWithPictureIndex:(NSInteger)index ofModel:(WallpaperDataModel *)model{
    PicController *vc = [PicController new];
    vc.dataList = self.dataList;
    vc.page = self.page;
    vc.picTitle = TitleTopic;
    vc.fn = model.pictures[index].fn;
    vc.special = 0;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}
//点击button触发的block调用的方法
-(void)downloadWithModel:(WallpaperDataModel *)model {
    //从网络下载图片
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    for (int i = 0; i < 2; i++) {
        [manager downloadImageWithURL:model.pictures[i].stand.url.wf_url options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            //状态栏转菊花
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            //取消状态栏转菊花
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            if (image) {
                if (i == 1) {
                    UIImageWriteToSavedPhotosAlbum(image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
                } else {
                    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
                }
            }
        }];
    }
}

//完成下载之后的提示
-(void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    //做一个alert对话框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"主题已保存到本地相册" message:nil preferredStyle:UIAlertControllerStyleAlert];
    //    step2:  创建可以收集用户意图的按键 — UIAlertAction， 创建时，不仅仅说明该按键上要显示的提示性文字，还要使用block的方式来设定点击了该按键之后要做的事情
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
    }];
    //    step3: 将创建好的  UIAlertAction 添加到 UIAlertController中
    [alert addAction:action1];
    //    step4：使用控制器的pressentViewController方法将AlertController推出显示
    [self presentViewController:alert animated:YES completion:nil];
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
    //给每个imageView单独设置手势触发的block
    [cell setPushBlock1:^(TopicCell *cell) {
        //封装了一个方法，要不然这里的代码重复率太高
        [self creatVcOfPicControllerWithPictureIndex:0 ofModel:model];
    }];
    [cell setPushBlock2:^(TopicCell *cell) {
        [self creatVcOfPicControllerWithPictureIndex:1 ofModel:model];
    }];
    //点击触发的block
    [cell setPushBlock3:^(TopicCell *cell) {
        [self downloadWithModel:model];
    }];
    return cell;
}

@end
