//
//  NSObject+Parse.h
//  极简壁纸
//
//  Created by 璠 王 on 2016/12/18.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYKit.h>

@interface NSObject (Parse)<YYModel>
+(id)parse:(id)JSON;
@end
