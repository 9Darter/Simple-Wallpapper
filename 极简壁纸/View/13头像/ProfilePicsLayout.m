//
//  ProfilePicsLayout.m
//  极简壁纸
//
//  Created by 璠 王 on 2016/12/25.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import "ProfilePicsLayout.h"

@implementation ProfilePicsLayout
-(instancetype)init {
    if (self = [super init]) {
        self.sectionInset = UIEdgeInsetsMake(17, 17, 17, 17);
        self.minimumLineSpacing = 33;
        self.minimumInteritemSpacing = 17;
        
        CGFloat width = (long)(([UIScreen mainScreen].bounds.size.width - 17 * 2 - 17) / 2);
        CGFloat height = width;
        self.itemSize = CGSizeMake(width, height);
    }
    return self;
}
@end
