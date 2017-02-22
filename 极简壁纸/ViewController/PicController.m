//
//  PicController.m
//  极简壁纸
//
//  Created by 璠 王 on 2016/12/25.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import "PicController.h"
#import <UShareUI/UShareUI.h>
#import "ClearCacheTool.h"
#import "SaveController.h"
#import "AppDelegate.h"

@interface PicController ()<iCarouselDelegate, iCarouselDataSource>
@property(nonatomic, strong)iCarousel *ic;//滚动页面由此轮子完成
@property(nonatomic, copy) NSMutableArray *mutablePicList;//数据数组，因为要加载更多，所以为可变数组
@property(nonatomic, strong) UIView *buttonView;//点击图片显示一个长条view，上面有若干button
@property(nonatomic, strong) UIImageView *saveView;//收藏按钮的view
@property(nonatomic, strong) UIImageView *lockView;//锁屏预览
@property(nonatomic, strong) UIImageView *homeView;//主屏预览
@property(nonatomic, assign) NSInteger currentPreview;//当前预览图
@property(nonatomic, strong) AppDelegate *delegate;
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
        
        //图片数组
        UIImage *backImage = [UIImage imageNamed:@"icon_toolbar_back_20x20_"];
        UIImage *previewImage = [UIImage imageNamed:@"icon_toolbar_preview_20x20_"];
        UIImage *downloadImage = [UIImage imageNamed:@"icon_toolbar_save_20x20_"];
        UIImage *shareImage = [UIImage imageNamed:@"icon_toolbar_share_20x20_"];
        UIImage *saveImage = [UIImage imageNamed:@"icon_toolbar_like_20x20_"];
        UIImage *moreImage = [UIImage imageNamed:@"icon_toolbar_more_20x20_"];
        NSArray *imageArray = [NSArray arrayWithObjects:backImage, previewImage, downloadImage, shareImage, saveImage, moreImage, nil];
        //文字数组
        NSArray *wordsArray = [NSArray arrayWithObjects:@"返回", @"预览", @"下载", @"分享", @"收藏", @"更多", nil];
        //手势数组
        UITapGestureRecognizer *tapBack = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)];
        UITapGestureRecognizer *tapPreview = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(preview)];
        UITapGestureRecognizer *tapDownload = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(download)];
        UITapGestureRecognizer *tapShare = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(share)];
        UITapGestureRecognizer *tapSave = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(save)];
        UITapGestureRecognizer *tapMore = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(more)];
        NSArray *gestureArray = [NSArray arrayWithObjects:tapBack, tapPreview, tapDownload, tapShare, tapSave, tapMore, nil];
        
        UIView *lastView = [UIView new];
        //用循环的方式创建6个带手势操作的view
        for (NSInteger i = 0; i < 6; i++) {
            //创建view
            UIView *singleButtonView = [UIView new];
            [_buttonView addSubview:singleButtonView];
            singleButtonView.backgroundColor = [UIColor clearColor];
            [singleButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(0);
                if (i == 0) {
                    make.left.equalTo(0);
                } else if (i == 5) {
                    make.right.equalTo(0);
                    make.left.equalTo(lastView.mas_right);
                    make.width.equalTo(lastView);
                } else {
                    make.left.equalTo(lastView.mas_right);
                    make.width.equalTo(lastView);
                }
            }];
            //添加一个图片view
            UIImageView *singleImageView = [[UIImageView alloc]initWithImage:imageArray[i]];
            singleImageView.contentMode = UIViewContentModeScaleAspectFit;
            [singleButtonView addSubview:singleImageView];
            [singleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(4);
                make.centerX.equalTo(0);
                make.width.equalTo(singleButtonView.mas_width).multipliedBy(0.4);
                make.height.equalTo(_buttonView.mas_height).multipliedBy(0.6);
            }];
            if (i == 4) {
                self.saveView = singleImageView;
            }
            //添加一个label
            UILabel *singleLabel = [UILabel new];
            singleLabel.text = wordsArray[i];
            singleLabel.textColor = [UIColor whiteColor];
            singleLabel.font = [UIFont systemFontOfSize:12];
            singleLabel.textAlignment = NSTextAlignmentCenter;
            [singleButtonView addSubview:singleLabel];
            [singleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(singleImageView.mas_bottom);
                make.left.right.equalTo(0);
            }];
            //添加一个手势
            [singleButtonView addGestureRecognizer:gestureArray[i]];
            //在循环外部找一个变量保存一下这个view，下次循环还要用这个view做约束的参考
            lastView = singleButtonView;
        }
    }
    return _buttonView;
}
-(UIImageView *)lockView {
    if (!_lockView) {
        _lockView = [UIImageView new];
        _lockView.image = [UIImage imageNamed:@"page_cell_style_preview_lock_cn_200x355_"];
        _lockView.alpha = 0;
        [self.view addSubview:_lockView];
        [_lockView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
    }
    return _lockView;
}
-(UIImageView *)homeView {
    if (!_homeView) {
        _homeView = [UIImageView new];
        _homeView.image = [UIImage imageNamed:@"page_cell_style_preview_home_cn_200x355_"];
        _homeView.alpha = 0;
        [self.view addSubview:_homeView];
        [_homeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
    }
    return _homeView;
}

#pragma mark - buttonView上的按键的触发方法
//返回
-(void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}
//下载图片到相册
-(void)download {
    UIImageWriteToSavedPhotosAlbum(((UIImageView *)self.ic.currentItemView).image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
}
//完成下载之后的提示
-(void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    [self.view showMsg:@"图片已保存到本地相册" autoHideAfterDely:2];
}
//预览
-(void)preview {
    //创建警告提醒
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"预览" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    // 添加按钮
    [alert addAction:[UIAlertAction actionWithTitle:@"锁屏预览" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        self.buttonView.alpha = 0;
        self.lockView.alpha = 1;
        self.currentPreview = 1;
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"主屏预览" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        self.buttonView.alpha = 0;
        self.homeView.alpha = 1;
        self.currentPreview = 2;
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"点击了取消按钮");
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}
//分享
-(void)share {
    //显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        // 调用下面的分享方法
        if (platformType == UMSocialPlatformType_Sina) {
            [self shareImageAndTextToPlatformType:platformType];
        } else {
            [self shareImageToPlatformType:platformType];
        }
    }];
}
- (void)shareImageAndTextToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //设置文本
    messageObject.text = @"这张图来自于一个叫“180壁纸”的App";
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    UIImageView *shareImageView = (UIImageView *)self.ic.currentItemView;
    shareObject.thumbImage = shareImageView.image;
    [shareObject setShareImage:shareImageView.image];
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}
- (void)shareImageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    UIImageView *shareImageView = (UIImageView *)self.ic.currentItemView;
    shareObject.thumbImage = shareImageView.image;
    [shareObject setShareImage:shareImageView.image];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}
//收藏
-(void)save {
    NSString *uniThumbURL = [self getURLFromDifferentModel:self.special][0];
    NSString *uniStandURL = [self getURLFromDifferentModel:self.special][1];
    
    UIImageView *currentItemView = (UIImageView *)self.ic.currentItemView;
    //遍历收藏的数组，若当前图片已被收藏，则取消点亮收藏图标；若没有被收藏，则点亮图标
    BOOL isSaved = NO;
    [self getSaveURLInDiskAndWrite:NO isSaved:isSaved thumbURL:uniThumbURL standURL:uniStandURL];
    for (NSString *thumbURL in self.delegate.thumbArr) {
        if ([thumbURL isEqualToString:uniThumbURL]) {
            isSaved = YES;
            break;
        }
    }
    self.saveView.image = isSaved ? [UIImage imageNamed:@"icon_toolbar_like_20x20_"] : [UIImage imageNamed:@"icon_toolbar_liked_20x20_"];
    
    isSaved ? [currentItemView showMsg:@"取消收藏" autoHideAfterDely:2] : [currentItemView showMsg:@"收藏成功" autoHideAfterDely:2];
    [self getSaveURLInDiskAndWrite:YES isSaved:isSaved thumbURL:uniThumbURL standURL:uniStandURL];
}
//更多
-(void)more {
    NSString *thumbPicPath = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/com.ibireme.yykit/images/data/"];
    NSString *standPicPath = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/default/com.hackemist.SDWebImageCache.default/"];
    NSInteger thumbPicSize = [ClearCacheTool getCacheSizeWithFilePath:thumbPicPath];
    NSInteger standPicSize = [ClearCacheTool getCacheSizeWithFilePath:standPicPath];
    NSString *picSize = [ClearCacheTool transformNSIntegerToNSString:thumbPicSize + standPicSize];
    NSString *actionTitle = [NSString stringWithFormat:@"清除缓存(%@)", picSize];

    //创建警告提醒
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:actionTitle message:nil preferredStyle:UIAlertControllerStyleAlert];
    // 添加按钮
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [ClearCacheTool clearCacheWithFilePath:thumbPicPath];
        [ClearCacheTool clearCacheWithFilePath:standPicPath];
        [self.view showMsg:@"已清除缓存" autoHideAfterDely:2];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"点击了取消按钮");
    }]];
    
    alert.popoverPresentationController.sourceView = self.ic.currentItemView;
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Method
-(NSArray *)getURLFromDifferentModel:(NSInteger)isSpecial {
    NSString *uniThumbURL = nil;
    NSString *uniStandURL = nil;
    if (self.special == 0) {
        WallpaperPictureModel *model = self.mutablePicList[self.ic.currentItemIndex];
        uniThumbURL = model.thumb.url;
        uniStandURL = model.stand.url;
    } else if (self.special == 1) {
        LockScreenDataModel *model = self.mutablePicList[self.ic.currentItemIndex];
        uniThumbURL = model.thumb.url;
        uniStandURL = model.stand.url;
    } else {
        SaveModel *model = self.mutablePicList[self.ic.currentItemIndex];
        uniThumbURL = model.thumb;
        uniStandURL = model.stand;
    }
    NSArray *arr = [NSArray arrayWithObjects:uniThumbURL, uniStandURL, nil];
    return arr;
}
//获取本地存储收藏URL的路径，将其保存在变量中，若需要增加／删除某个URL，也可以完成
-(void)getSaveURLInDiskAndWrite:(BOOL)willWrite isSaved:(BOOL)isSaved thumbURL:(NSString *)thumbURL standURL:(NSString *)standURL {
    //获取documents路径
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *thumbArrPath = [docPath stringByAppendingPathComponent:@"thumbArr.plist"];
    NSString *standArrPath = [docPath stringByAppendingPathComponent:@"standArr.plist"];
    //读磁盘，添加url到plist文件中
    NSMutableArray *thumbArr = [[NSMutableArray alloc]initWithContentsOfFile:thumbArrPath];
    NSMutableArray *standArr = [[NSMutableArray alloc]initWithContentsOfFile:standArrPath];
    self.delegate.thumbArr = thumbArr;
    self.delegate.standArr = standArr;
    if (willWrite) {
        isSaved ? [standArr removeObject:standURL] : [standArr addObject:standURL];
        isSaved ? [thumbArr removeObject:thumbURL] : [thumbArr addObject:thumbURL];
        [thumbArr writeToFile:thumbArrPath atomically:YES];
        [standArr writeToFile:standArrPath atomically:YES];
    }
}
#pragma mark - Life
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    self.currentPreview = 0;
    
    //把传进来的数组进行遍历，每个数组元素中都包含多个图片，所以把这个数组中所有图片放到一个数组中，作为ic的数组源
    if (self.special == 1) {
        for (int i = 0; i < self.lockDataList.count; i++) {
            [self.mutablePicList addObjectsFromArray:self.lockDataList[i]];
        }
    } else if (self.special == 0) {
        for (int i = 0; i < self.dataList.count; i++) {
            [self.mutablePicList addObjectsFromArray:self.dataList[i].pictures];
        }
    } else {
        [self.mutablePicList addObjectsFromArray:self.saveDataList];
    }
    
    //设置ic的代理
    self.ic.delegate = self;
    self.ic.dataSource = self;
    //ic要一页一页地显示
    self.ic.pagingEnabled = YES;
    //长条view的初始状态为隐藏
    self.buttonView.alpha = 1;
    
    //获取当前应用程序的代理
    self.delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //在前一页面中点击哪个图片，哪个图片就需要成为此页面中展示的图片，所以在进入页面后，设置当前页面为之前点击的那个图片
    //通过遍历数据源数组，判断传进来的fn与该数据源中哪个图片fn一致，就显示该图片
    
    if (self.special == 1) {
        for (LockScreenDataModel *model in self.mutablePicList) {
            if ([model.fn integerValue] == self.fn) {
                NSInteger index = [self.mutablePicList indexOfObject:model];
                [self.ic scrollToItemAtIndex:index animated:NO];
                break;
            }
        }
    } else if (self.special == 0){
        for (WallpaperPictureModel *model in self.mutablePicList) {
            if (model.fn == self.fn) {
                NSInteger index = [self.mutablePicList indexOfObject:model];
                [self.ic scrollToItemAtIndex:index animated:NO];
                break;
            }
        }
    } else {
        [self.ic scrollToItemAtIndex:self.selectedIndexPathRow animated:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)prefersStatusBarHidden {
    return YES;
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
    view.contentMode = UIViewContentModeScaleAspectFill;
    //由于前一页将低清图片已缓存，此处仅设置图片为之前缓存的图片，这样在下载高清图片的过程中先脱机显示低清图片
    //下载高清图片的过程不在此处，因为会耗费大量流量，应该滑倒哪张图片再去下载
    if (self.special == 0) {
        WallpaperPictureModel *model = self.mutablePicList[index];
        [((UIImageView *)view) setImageWithURL:model.thumb.url.wf_url placeholder:nil options:YYWebImageOptionProgressive completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
            NSLog(@"标准低清图片加载完毕");
        }];
    } else if (self.special == 1) {
        LockScreenDataModel *model = self.mutablePicList[index];
        [((UIImageView *)view) setImageWithURL:model.thumb.url.wf_url placeholder:nil options:YYWebImageOptionProgressive completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
            NSLog(@"特殊低清图片加载完毕");
        }];
    } else {
        SaveModel *model = self.mutablePicList[index];
        [((UIImageView *)view) setImageWithURL:model.thumb.wf_url placeholder:nil options:YYWebImageOptionProgressive completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
            NSLog(@"收藏低清图片加载完毕");
        }];
    }
    
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
    if (self.special != 0 && self.special != 1) {
        return;
    }
    if (self.ic.currentItemIndex == self.mutablePicList.count - 1) {
        if (self.special) {
            [NetManager getLockScreenModelWithSpecial:self.picTitle andPage:self.page + 1 andLimit:kLimit completionHandler:^(LockScreenModel *model, NSError *error) {
                if (!error) {
                    for (int i = 0; i < model.data.count; i++) {
                        [self.mutablePicList addObjectsFromArray:model.data[i]];
                    }
                }
                [self.ic reloadData];
            }];
        } else {
            [NetManager getWallpaperModelWithTitle:self.picTitle andPage:self.page + 1 andLimit:kLimit completionHandler:^(WallpaperModel *model, NSError *error) {
                if (!error) {
                    for (int i = 0; i < model.data.count; i++) {
                        [self.mutablePicList addObjectsFromArray:model.data[i].pictures];
                    }
                }
                [self.ic reloadData];
            }];
        }
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
        if (self.currentPreview == 1) {
            self.lockView.alpha = 0;
        }
        if (self.currentPreview == 2){
            self.homeView.alpha = 0;
        }
    }];
}

//此方法为结束每一张滑动动画后触发的方法，在此方法中进行当前图片的高清版下载，下载完成后再设置显示
//如果直接用setImageWithURL方法，将会导致低高清图片转换时的短暂闪烁，影响用户体验
-(void)carouselDidEndScrollingAnimation:(iCarousel *)carousel {
    
    NSString *uniThumbURL = [self getURLFromDifferentModel:self.special][0];
    NSString *uniStandURL = [self getURLFromDifferentModel:self.special][1];

    UIImageView *currentItemView = (UIImageView *)self.ic.currentItemView;
    
    [currentItemView showPie];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager loadImageWithURL:uniStandURL.wf_url options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        NSLog(@"正在下载高清图片：%.0lf%%", (CGFloat)receivedSize / expectedSize * 100);
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        if (image) {
            [currentItemView hideHUD];
            [currentItemView setImage:image];
        }
    }];
    
    //遍历收藏的数组，若当前图片已被收藏，则点亮收藏图标
    BOOL isSaved = NO;
    [self getSaveURLInDiskAndWrite:NO isSaved:isSaved thumbURL:uniThumbURL standURL:uniStandURL];
    for (NSString *thumbURL in self.delegate.thumbArr) {
        if ([thumbURL isEqualToString:uniThumbURL]) {
            isSaved = YES;
            break;
        }
    }
    self.saveView.image = isSaved ? [UIImage imageNamed:@"icon_toolbar_liked_20x20_"] : [UIImage imageNamed:@"icon_toolbar_like_20x20_"];
}
@end
