//
//  ProfilePicCell.m
//  极简壁纸
//
//  Created by 璠 王 on 2016/12/25.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import "ProfilePicCell.h"

@implementation ProfilePicCell
-(UIImageView *)iconIV {
    if (!_iconIV) {
        _iconIV = [UIImageView new];
        _iconIV.contentMode = UIViewContentModeScaleAspectFill;
        _iconIV.clipsToBounds = YES;
        CGFloat width = (long)(([UIScreen mainScreen].bounds.size.width - 17 * 2 - 17) / 2);
        _iconIV.layer.cornerRadius = width / 2;
        _iconIV.layer.borderWidth = 3;
        _iconIV.layer.borderColor = [UIColor whiteColor].CGColor;
        
        [self.contentView addSubview:_iconIV];
        [_iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
    }
    return _iconIV;
}
@end
