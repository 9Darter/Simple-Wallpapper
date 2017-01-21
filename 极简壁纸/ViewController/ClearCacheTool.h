//
//  ClearCacheTool.h
//  极简壁纸
//
//  Created by 璠 王 on 2017/1/20.
//  Copyright © 2017年 璠 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClearCacheTool : NSObject
/*s*
 *  获取path路径下文件夹的大小
 *
 *  @param path 要获取的文件夹 路径
 *
 *  @return 返回path路径下文件夹的大小
 */
+ (NSInteger)getCacheSizeWithFilePath:(NSString *)path;
+ (NSString *)transformNSIntegerToNSString:(NSInteger)totleSize;
/**
 *  清除path路径下文件夹的缓存
 *
 *  @param path  要清除缓存的文件夹 路径
 *
 *  @return 是否清除成功
 */
+ (BOOL)clearCacheWithFilePath:(NSString *)path;
@end
