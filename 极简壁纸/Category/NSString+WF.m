//
//  NSString+WF.m
//  极简壁纸
//
//  Created by 璠 王 on 2016/12/18.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import "NSString+WF.h"

@implementation NSString (WF)
-(NSURL *)wf_url {
    return [NSURL URLWithString:self];
}
@end
