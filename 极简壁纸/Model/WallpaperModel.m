//
//  WallpaperModel.m
//  极简壁纸
//
//  Created by 璠 王 on 2016/12/18.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import "WallpaperModel.h"

@implementation WallpaperModel
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{@"data": [WallpaperDataModel class]};
}
@end

@implementation WallpaperDataModel
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{@"pictures": [WallpaperPictureModel class]};
}
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{@"descriptionField": @"description",
             @"shareUtc": @"share_utc"};
}
@end

@implementation WallpaperPictureModel

@end

@implementation WallpaperQualityModel

@end
