//
//  LockScreenModel.h
//  极简壁纸
//
//  Created by tarena1 on 2016/12/22.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LockScreenDataModel, LockScreenQualityModel;

@interface LockScreenModel : NSObject
@property (nonatomic, assign) NSNumber *after;
@property (nonatomic, strong) NSArray * data;
@property (nonatomic, assign) NSNumber *status;
@property (nonatomic, assign) NSNumber *total;
@property (nonatomic, assign) NSNumber *totalpage;

+ (id)parseDic:(NSDictionary *)dic;
@end

@interface LockScreenDataModel : NSObject
@property(nonatomic, strong) NSString *albumShareUtc;
@property(nonatomic, strong) NSString *albumfn;
@property(nonatomic, strong) NSString *fn;
@property(nonatomic, strong) NSString *shareUtc;
@property(nonatomic, strong) NSString *source;
@property(nonatomic, strong) NSString *tags;
@property(nonatomic, strong) LockScreenQualityModel *low;
@property(nonatomic, strong) LockScreenQualityModel *stand;
@property(nonatomic, strong) LockScreenQualityModel *thumb;

+ (id)parseDic:(NSDictionary *)dic;
+ (id)parseArr:(NSArray *)arr;

//+ (id)parseAdDic:(NSDictionary *)dic;
+ (id)parseInnerArr:(NSArray *)arr;
@end

@interface LockScreenQualityModel : NSObject
@property (nonatomic, assign) NSNumber *height;
@property (nonatomic, strong) NSString * url;
@property (nonatomic, assign) NSNumber *width;

+ (id)parseDic:(NSDictionary *)dic;
@end
