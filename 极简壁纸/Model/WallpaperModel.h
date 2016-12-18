//
//  WallpaperModel.h
//  极简壁纸
//
//  Created by 璠 王 on 2016/12/18.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WallpaperDataModel, WallpaperPictureModel, WallpaperQualityModel;

@interface WallpaperModel : NSObject
@property (nonatomic, assign) NSInteger after;
@property (nonatomic, strong) NSArray<WallpaperDataModel *> * data;
@property (nonatomic, assign) NSInteger p;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) NSInteger totalpage;
@end

@interface WallpaperDataModel : NSObject
@property (nonatomic, strong) NSString * descriptionField;
@property (nonatomic, strong) NSString * fullname;
@property (nonatomic, strong) NSArray<WallpaperPictureModel *> * pictures;
@property (nonatomic, strong) NSString * shareUtc;
@property (nonatomic, strong) NSString * title;
@end

@interface WallpaperPictureModel : NSObject
@property (nonatomic, assign) NSInteger fn;
@property (nonatomic, strong) WallpaperQualityModel * low;
@property (nonatomic, strong) WallpaperQualityModel * stand;
@property (nonatomic, strong) WallpaperQualityModel * thumb;
@end

@interface WallpaperQualityModel : NSObject
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, strong) NSString * url;
@property (nonatomic, assign) NSInteger width;
@end
