//
//  BaseNetmanager.h
//  极简壁纸
//
//  Created by 璠 王 on 2016/12/18.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseNetmanager : NSObject
+(id)GET:(NSString *)path parameters:(NSDictionary *)params completionHandler:(void(^)(id responseObj, NSError *error))completionHandler;
@end
