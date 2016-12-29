//
//  PicController.m
//  极简壁纸
//
//  Created by 璠 王 on 2016/12/25.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import "PicController.h"

@interface PicController ()<iCarouselDelegate, iCarouselDataSource>
@property(nonatomic, strong)iCarousel *ic;//滚动页面由此轮子完成
@property(nonatomic, copy) NSMutableArray<WallpaperPictureModel *> *mutablePicList;//数据数组，因为要加载更多，所以为可变数组
@property(nonatomic, strong) UIView *buttonView;//点击图片显示一个长条view，上面有若干button
@end

@implementation PicController
#pragma mark - Lazy
-(NSMutableArray *)mutablePicList {
    if (!_mutablePicList) {
        _mutablePicList = [NSMutableArray new];
    }
    return _mutablePicList;
}
-(iCarousel *)ic {
    if (!_ic) {
        _ic = [iCarousel new];
        
        [self.view addSubview:_ic];
        [_ic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
    }
    return _ic;
}
-(UIView *)buttonView {
    if (!_buttonView) {
        _buttonView = [UIView new];
        _buttonView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.7];
        [self.view addSubview:_buttonView];
        [_buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(-50);
            make.left.right.equalTo(0);
            make.height.equalTo(self.view.mas_height).multipliedBy(150 / 2001.0);
        }];
        
        //添加此view上的button
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [backButton setBackgroundImage:[UIImage imageNamed:@"icon_toolbar_back_20x20_"] forState:UIControlStateNormal];
        
        [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonView addSubview:backButton];
        [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(10);
            make.bottom.equalTo(-10);
            make.width.equalTo(50);
        }];
    }
    return _buttonView;
}

#pragma mark - buttonView上的按键的触发方法
-(void)back:sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Life
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //把传进来的数组进行遍历，每个数组元素中都包含多个图片，所以把这个数组中所有图片放到一个数组中，作为ic的数组源
    for (int i = 0; i < self.dataList.count; i++) {
        [self.mutablePicList addObjectsFromArray:self.dataList[i].pictures];
    }
    
    //设置ic的代理
    self.ic.delegate = self;
    self.ic.dataSource = self;
    //ic要一页一页地显示
    self.ic.pagingEnabled = YES;
    //长条view的初始状态为隐藏
    self.buttonView.alpha = 1;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //在前一页面中点击哪个图片，哪个图片就需要成为此页面中展示的图片，所以在进入页面后，设置当前页面为之前点击的那个图片
    //通过遍历数据源数组，判断传进来的fn与该数据源中哪个图片fn一致，就显示该图片
    for (WallpaperPictureModel *model in self.mutablePicList) {
        if (model.fn == self.fn) {
            NSInteger index = [self.mutablePicList indexOfObject:model];
            [self.ic scrollToItemAtIndex:index animated:NO];
            break;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - iC Delegate
//图片数量为数据源数组中元素的个数
-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return self.mutablePicList.count;
}
//设置每张图片
-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    if (!view) {
        view = [[UIImageView alloc]initWithFrame:carousel.bounds];
    }
    
    //由于前一页将低清图片已缓存，此处仅设置图片为之前缓存的图片，这样在下载高清图片的过程中先脱机显示低清图片
    //下载高清图片的过程不在此处，因为会耗费大量流量，应该滑倒哪张图片再去下载
    WallpaperPictureModel *model = self.mutablePicList[index];
        [((UIImageView *)view) setImageWithURL:model.thumb.url.wf_url placeholder:nil options:YYWebImageOptionProgressive completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
            NSLog(@"低清图片加载完毕");
        }];
    return view;
}

//显示样式
-(CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value {
    if (option == iCarouselOptionWrap) {
        value = NO;
    }
    return value;
}

//捕捉到滑动图片后的触发方法
//每当滑动了图片，都会判断一下该图片是否为数据源的最后一张。如果是，就进行网络加载扩充数据源，使后续的图片可以继续展示
-(void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel {
    if (self.ic.currentItemIndex == self.mutablePicList.count - 1) {
        [NetManager getWallpaperModelWithTitle:self.picTitle andPage:self.page + 1 andLimit:kLimit completionHandler:^(WallpaperModel *model, NSError *error) {
            if (!error) {
                for (int i = 0; i < self.dataList.count; i++) {
                    [self.mutablePicList addObjectsFromArray:model.data[i].pictures];
                }
            }
            [self.ic reloadData];
        }];
    }
}

//点击某个图片后触发该方法，使长条view显示或隐藏
-(void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    [UIView animateWithDuration:.5 animations:^{
        if (self.buttonView.alpha == 0) {
            self.buttonView.alpha = 1;
        } else {
            self.buttonView.alpha = 0;
        }
    }];
}

//此方法为结束每一张滑动动画后触发的方法，在此方法中进行当前图片的高清版下载，下载完成后再设置显示
//如果直接用setImageWithURL方法，将会导致低高清图片转换时的短暂闪烁，影响用户体验
-(void)carouselDidEndScrollingAnimation:(iCarousel *)carousel {
    WallpaperPictureModel *model = self.mutablePicList[self.ic.currentItemIndex];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:model.stand.url.wf_url options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (image) {
            [(UIImageView *)self.ic.currentItemView setImage:image];
        }
    }];
}
@end
