//
//  PicController.h
//  极简壁纸
//
//  Created by 璠 王 on 2016/12/25.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WallpaperModel.h"
#import "NetManager.h"


@interface PicController : UIViewController
@property(nonatomic, copy) NSArray<WallpaperDataModel *> *dataList; //浏览页面传进来的当前加载的所有数据
@property(nonatomic, assign) NSInteger fn;//点击哪个图片，就传进来哪张图片的fn，此属性记录传进来的这个fn
@property(nonatomic, assign) NSInteger page;//接收传进来的url里的page
@property Title picTitle;//接收传进来的url里的三个字符串
@end
