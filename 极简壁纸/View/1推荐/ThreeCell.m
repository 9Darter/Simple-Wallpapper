//
//  ThreeCell.m
//  极简壁纸
//
//  Created by tarena1 on 2016/12/20.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import "ThreeCell.h"

@implementation ThreeCell
-(UIImageView *)firstIV {
    if (!_firstIV) {
        _firstIV = [UIImageView new];
        [self.contentView addSubview:_firstIV];
        CGFloat width = (kScreenWidth - 14) * (708 / 1086.0);
        CGFloat height = width * (16 / 9.0);
        [_firstIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(7);
            make.top.equalTo(10);
            make.width.equalTo(width);
            make.height.equalTo(height);
        }];
    }
    return _firstIV;
}

-(UIImageView *)secondIV {
    if (!_secondIV) {
        _secondIV = [UIImageView new];
        [self.contentView addSubview:_secondIV];
        [_secondIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-7);
            make.top.equalTo(self.firstIV);
            make.left.equalTo(self.firstIV.mas_right).offset(7);
        }];
    }
    return _secondIV;
}

-(UIImageView *)thirdIV {
    if (!_thirdIV) {
        _thirdIV = [UIImageView new];
        [self.contentView addSubview:_thirdIV];
        [_thirdIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.secondIV);
            make.bottom.equalTo(self.firstIV);
            make.top.equalTo(self.secondIV.mas_bottom).offset(7);
            make.height.equalTo(self.secondIV);
        }];
    }
    return _thirdIV;
}







- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
