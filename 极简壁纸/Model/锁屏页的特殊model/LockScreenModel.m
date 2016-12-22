//
//  LockScreenModel.m
//  极简壁纸
//
//  Created by tarena1 on 2016/12/22.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import "LockScreenModel.h"

@implementation LockScreenModel
+ (id)parseDic:(NSDictionary *)dic{
    LockScreenModel *model = [self new];
    model.after = dic[@"after"];
    model.data = [LockScreenDataModel parseArr: dic[@"data"]];
    model.status = dic[@"status"];
    model.total = dic[@"total"];
    model.totalpage = dic[@"totalpage"];
    return model;
}
@end

@implementation LockScreenDataModel
+ (id)parseDic:(NSDictionary *)dic{
    LockScreenDataModel *model = [self new];
    model.albumShareUtc = dic[@"album_share_utc"];
    model.albumfn = dic[@"albumfn"];
    model.fn = dic[@"fn"];
    model.shareUtc = dic[@"share_utc"];
    model.source = dic[@"source"];
    model.tags = dic[@"tags"];
    model.low = [LockScreenQualityModel parseDic:dic[@"low"]];
    model.stand = [LockScreenQualityModel parseDic:dic[@"stand"]];
    model.thumb = [LockScreenQualityModel parseDic:dic[@"thumb"]];
    return model;
}
//+ (id)parseAdDic:(NSDictionary *)dic{
//    LockScreenDataModel *model = [self new];
//    model.albumShareUtc = dic[@"album_share_utc"];
//    model.albumfn = dic[@"albumfn"];
//    model.fn = dic[@"fn"];
//    model.shareUtc = dic[@"share_utc"];
//    model.source = dic[@"source"];
//    model.tags = dic[@"tags"];
//    model.low = [LockScreenQualityModel parseDic:dic[@"low"]];
//    model.stand = [LockScreenQualityModel parseDic:dic[@"stand"]];
//    model.thumb = [LockScreenQualityModel parseDic:dic[@"thumb"]];
//    return model;
//}

+ (id)parseArr:(NSArray *)arr{
    NSMutableArray *tmpArr = [NSMutableArray new];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSArray class]]) {
            [tmpArr addObject:[LockScreenDataModel parseInnerArr:obj]];
        }
    }];
    return tmpArr.copy;
}

+ (id)parseInnerArr:(NSArray *)arr{
    NSMutableArray *tmpArr = [NSMutableArray new];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [tmpArr addObject:[LockScreenDataModel parseDic:obj]];
    }];
    return tmpArr.copy;
}


@end

@implementation LockScreenQualityModel
+ (id)parseDic:(NSDictionary *)dic{
    LockScreenQualityModel *model = [self new];
    model.height = dic[@"height"];
    model.url = dic[@"url"];
    model.width = dic[@"width"];
    return model;
}
@end



/*
 @implementation GameCategoryModel
 + (id)parseDic:(NSDictionary *)dic{
 GameCategoryModel *model = [self new];
 model.error = dic[@"error"];
 model.data = [GameCategoryDataModel parseArr: dic[@"data"]];
 return model;
 }
 @end
 
 @implementation GameCategoryDataModel
 
 + (id)parseDic:(NSDictionary *)dic{
 GameCategoryDataModel *model = [self new];
 model.cate_id = dic[@"cate_id"];
 model.game_icon = dic[@"game_icon"];
 model.game_name = dic[@"game_name"];
 model.game_src = dic[@"game_src"];
 model.game_url = dic[@"game_url"];
 model.online_room = dic[@"online_room"];
 model.online_room_ios = dic[@"online_room_ios"];
 model.short_name = dic[@"short_name"];
 return model;
 }
 + (id)parseArr:(NSArray *)arr{
 NSMutableArray *tmpArr = [NSMutableArray new];
 [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
 [tmpArr addObject:[self parseDic:obj]];
 }];
 return tmpArr.copy;
 }

 */
