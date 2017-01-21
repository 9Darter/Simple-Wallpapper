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

@interface SaveController ()
@property (nonatomic, copy) NSArray<NSString *> *thumbDataList;
@property (nonatomic, copy) NSArray *standDataList;
@end

@implementation SaveController
#pragma mark - 重写初始化方法
-(instancetype)init {
    if (self = [super initWithCollectionViewLayout:[MostPopularLayout new]]) {
        
    }
    return self;
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
        self.thumbDataList = [[NSArray alloc]initWithContentsOfFile:thumbArrPath];
        self.standDataList = [[NSArray alloc]initWithContentsOfFile:standArrPath];
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
    return self.thumbDataList.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MostPopularCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"MostPopularCell" forIndexPath:indexPath];
    [cell.iconIV setImageURL:self.thumbDataList[indexPath.row].wf_url];
    return cell;
}


@end
