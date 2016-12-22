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
@property (nonatomic, assign) NSInteger after;
@property (nonatomic, strong) NSArray<NSArray<LockScreenDataModel *> *> * data;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) NSInteger totalpage;
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
@end

@interface LockScreenQualityModel : NSObject
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, strong) NSString * url;
@property (nonatomic, assign) NSInteger width;
@end
