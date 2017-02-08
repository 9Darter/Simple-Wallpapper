//
//  SaveModel.m
//  极简壁纸
//
//  Created by 璠 王 on 2017/2/8.
//  Copyright © 2017年 璠 王. All rights reserved.
//

#import "SaveModel.h"

@implementation SaveModel
-(instancetype)initWithThumb:(NSString *)thumbURL andStand:(NSString *)standURL {
    if (self = [super init]) {
        self.thumb = thumbURL;
        self.stand = standURL;
    }
    return self;
}
@end
