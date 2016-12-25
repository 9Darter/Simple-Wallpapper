//
//  MostPopularLayout.m
//  极简壁纸
//
//  Created by 璠 王 on 2016/12/24.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import "MostPopularLayout.h"

@implementation MostPopularLayout
-(instancetype)init {
    if (self = [super init]) {
        self.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        self.minimumLineSpacing = 5;
        self.minimumInteritemSpacing = 5;
        
        CGFloat width = (long)(([UIScreen mainScreen].bounds.size.width - 5 * 2 - 5 * 2) / 3);
        CGFloat height = width * 16 / 9.0;
        self.itemSize = CGSizeMake(width, height);
    }
    return self;
}
@end
