//
//  NetManager.m
//  极简壁纸
//
//  Created by 璠 王 on 2016/12/18.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import "NetManager.h"

@implementation NetManager
//通用网络请求
+(id)getWallpaperModelWithTitle:(Title)title andPage:(NSInteger)page andLimit:(NSInteger)limit completionHandler:(void (^)(WallpaperModel *, NSError *))completionHandler {
    NSString *path = nil;
    switch (title) {
        case 1:
            path = [NSString stringWithFormat:kPath, @"1988107", @"051071101", @"87044", page, limit];
            break;
        case 2:
            path = [NSString stringWithFormat:kPath, @"1988619", @"051071101302200", @"87556", page, limit];
            break;
        case 3:
            path = [NSString stringWithFormat:kPath, @"1989643", @"051106300", @"87812", page, limit];
            break;
        case 4:
            path = [NSString stringWithFormat:kPath, @"1989899", @"051106301", @"88068", page, limit];
            break;
        case 5:
            path = [NSString stringWithFormat:kPath, @"1988875", @"051071101", @"1028", page, limit];
            break;
        case 6:
            path = [NSString stringWithFormat:kPath, @"1989131", @"051071101", @"1284", page, limit];
            break;
        case 7:
            path = [NSString stringWithFormat:kPath, @"3129099", @"051071101", @"23044", page, limit];
            break;
        case 8:
            path = [NSString stringWithFormat:kPath, @"1988363", @"051108", @"516", page, limit];
            break;
        case 9:
            path = [NSString stringWithFormat:kPath, @"1990411", @"051108", @"2564", page, limit];
            break;
        case 10:
            path = [NSString stringWithFormat:kPath, @"1990667", @"051108", @"2820", page, limit];
            break;
        case 11:
            path = [NSString stringWithFormat:kPath, @"1990923", @"051108", @"3076", page, limit];
            break;
        case 12:
            path = [NSString stringWithFormat:kPath, @"3481099", @"051106303", @"88324", page, limit];
            break;
        case 13:
            path = [NSString stringWithFormat:kPath, @"1990155", @"051106304", @"88580", page, limit];
            break;
    }
    path = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        !completionHandler ?: completionHandler([WallpaperModel parse:responseObj], error);
    }];
}

//锁屏页的特殊网络请求
+(id)getLockScreenModelWithSpecial:(NSInteger)special andPage:(NSInteger)page andLimit:(NSInteger)limit completionHandler:(void (^)(LockScreenModel *, NSError *))completionHandler {
    NSString *path = nil;
    switch (special) {
        case 3:
            path = [NSString stringWithFormat:kPath, @"1989643", @"051106300", @"87812", page, limit];
            break;
        case 4:
            path = [NSString stringWithFormat:kPath, @"1989899", @"051106301", @"88068", page, limit];
            break;
        case 8:
            path = [NSString stringWithFormat:kPath, @"1988363", @"051108", @"516", page, limit];
            break;
        case 9:
            path = [NSString stringWithFormat:kPath, @"1990411", @"051108", @"2564", page, limit];
            break;
        case 10:
            path = [NSString stringWithFormat:kPath, @"1990667", @"051108", @"2820", page, limit];
            break;
        default: //case 11:
            path = [NSString stringWithFormat:kPath, @"1990923", @"051108", @"3076", page, limit];
            break;

    }
    path = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        //此处用锁屏model的类方法去解析，不要用分类中的通用parse方法
        !completionHandler ?: completionHandler([LockScreenModel parseDic:responseObj], error);
    }];
}
@end
