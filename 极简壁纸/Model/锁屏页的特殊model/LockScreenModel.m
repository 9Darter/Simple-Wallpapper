//
//  LockScreenModel.m
//  极简壁纸
//
//  Created by tarena1 on 2016/12/22.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import "LockScreenModel.h"

@implementation LockScreenModel
//+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
//    return @{@"data": [LockScreenDataModel class]};
//}
@end

@implementation LockScreenDataModel
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{@"albumShareUtc": @"album_share_utc",
             @"shareUtc": @"share_utc"};
}
@end

@implementation LockScreenQualityModel

@end
