//
//  HomeScreenLayout.m
//  极简壁纸
//
//  Created by 璠 王 on 2016/12/23.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import "HomeScreenLayout.h"

@implementation HomeScreenLayout
-(instancetype)init {
    if (self = [super init]) {
        self.sectionInset = UIEdgeInsetsMake(7, 7, 7, 7);
        self.minimumLineSpacing = 7;
        self.minimumInteritemSpacing = 7;
        
        CGFloat width = (long)(([UIScreen mainScreen].bounds.size.width - 7 * 2 - 7) / 2);
        CGFloat height = width * 16 / 9.0;
        self.itemSize = CGSizeMake(width, height);
    }
    return self;
}
@end
