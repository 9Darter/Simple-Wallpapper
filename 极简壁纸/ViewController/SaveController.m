//
//  SaveController.m
//  极简壁纸
//
//  Created by 璠 王 on 2017/1/21.
//  Copyright © 2017年 璠 王. All rights reserved.
//

#import "SaveController.h"
#import "MostPopularLayout.h"
#import "MostPopularCell.h"
#import "SaveModel.h"

#import "PicController.h"

@interface SaveController ()
//@property (nonatomic, copy) NSArray<NSString *> *thumbDataList;
//@property (nonatomic, copy) NSArray<NSString *> *standDataList;
@property (nonatomic, strong) NSMutableArray<SaveModel *> *dataList;
@end

@implementation SaveController
#pragma mark - 重写初始化方法
-(instancetype)init {
    if (self = [super initWithCollectionViewLayout:[MostPopularLayout new]]) {
        
    }
    return self;
}
#pragma mark - Lazy
-(NSMutableArray<SaveModel *> *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray new];
    }
    return _dataList;
}
#pragma mark - Life
- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"收藏";
    //注册cell
    [self.collectionView registerClass:[MostPopularCell class] forCellWithReuseIdentifier:@"MostPopularCell"];
    //刷新及网络请求
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //取硬盘中的数组
        //获取documents路径
        NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString *thumbArrPath = [docPath stringByAppendingPathComponent:@"thumbArr.plist"];
        NSString *standArrPath = [docPath stringByAppendingPathComponent:@"standArr.plist"];
        //读磁盘，将磁盘中的数组赋给本类似有属性数组，作为数据源
        NSArray *thumbURLArr = [[NSArray alloc]initWithContentsOfFile:thumbArrPath];
        NSArray *standURLArr = [[NSArray alloc]initWithContentsOfFile:standArrPath];
        //再弄一个数据模型，这样方便后续的数据处理
        for (int i = 0; i < thumbURLArr.count; i++) {
            //每循环一次，就新建一个model，并赋值，再添加到数据源数组中，这样数据源就做好了
            SaveModel *model = [[SaveModel alloc]initWithThumb:thumbURLArr[i] andStand:standURLArr[i]];
            [self.dataList addObject:model];
        }
        
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
    }];
    
    [self.collectionView.mj_header beginRefreshing];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataList.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MostPopularCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"MostPopularCell" forIndexPath:indexPath];
    [cell.iconIV setImageURL:self.dataList[indexPath.row].thumb.wf_url];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PicController *vc = [PicController new];
    vc.saveDataList = self.dataList;
    vc.selectedIndexPathRow = indexPath.row;
    vc.isSpecial = 2;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

@end
