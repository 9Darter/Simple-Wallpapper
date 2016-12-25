//
//  NetManager.h
//  极简壁纸
//
//  Created by 璠 王 on 2016/12/18.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WallpaperModel.h"
#import "LockScreenModel.h"
#import "BaseNetmanager.h"
typedef NS_ENUM(NSUInteger, Title) {
    TitleRecommended = 1,
    TitleTopic,
    TitleLockedScreen,
    TitleHomeScreen,
    TitlePerfectCouple,
    TitlePeopleWatching,
    TitleLatest,
    TitleMostPopular,
    TitleBoys,
    TitleGirls,
    TitleWordsWallpapers,
    TitleChattingBackgrounds,
    TitleProfilePics
};

@interface NetManager : BaseNetmanager
//通用的网络请求
+(id)getWallpaperModelWithTitle:(Title)title andPage:(NSInteger)page andLimit:(NSInteger)limit completionHandler:(void(^)(WallpaperModel *model, NSError *error))completionHandler;
//锁屏页的特殊网络请求
+(id)getLockScreenModelWithSpecial:(NSInteger)special andPage:(NSInteger)page andLimit:(NSInteger)limit completionHandler:(void(^)(LockScreenModel *model, NSError *error))completionHandler;
@end


/*
 http://page.appdao.com/forward?link=1988107&style=051071101&item=91396&page=1&limit=25&after=&screen_w=1125&screen_h=2001&ir=0&app=AR_Desktop&v=2.4&lang=zh-Hans-CN&it=1481810734.391166&ots=4&jb=0&as=0&mobclix=0&deviceid=replaceudid&macaddr=&idv=08498196-57B4-4962-871D-07BB7BEE660A&idvs=&ida=F1969E49-2FC8-4DE1-8C83-324465EFBDA7&phonetype=iphone&model=iphone8%2C2&osn=iPhone%20OS&osv=10.2&tz=8
 
 */
