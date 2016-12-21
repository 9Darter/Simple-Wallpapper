//
//  NineCell.m
//  极简壁纸
//
//  Created by tarena1 on 2016/12/21.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import "NineCell.h"

@implementation NineCell

-(UIImageView *)firstIV {
    if (!_firstIV) {
        _firstIV = [UIImageView new];
        [self.contentView addSubview:_firstIV];
        CGFloat width = (kScreenWidth - 21) / 2;
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
            make.top.equalTo(self.secondIV);
            make.left.equalTo(self.secondIV.mas_right).offset(7);
            make.right.equalTo(-7);
            make.width.equalTo(self.secondIV);
        }];
    }
    return _thirdIV;
}

-(UIImageView *)fourthIV {
    if (!_fourthIV) {
        _fourthIV = [UIImageView new];
        [self.contentView addSubview:_fourthIV];
        [_fourthIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.secondIV.mas_bottom).offset(7);
            make.bottom.equalTo(self.firstIV);
            make.left.equalTo(self.secondIV);
            make.height.equalTo(self.secondIV);
            make.right.equalTo(self.secondIV);
        }];
    }
    return _fourthIV;
}

-(UIImageView *)fifthIV {
    if (!_fifthIV) {
        _fifthIV = [UIImageView new];
        [self.contentView addSubview:_fifthIV];
        [_fifthIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.fourthIV);
            make.bottom.equalTo(self.fourthIV);
            make.left.equalTo(self.thirdIV);
            make.right.equalTo(self.thirdIV);
        }];
    }
    return _fifthIV;
}

-(UIImageView *)sixIV {
    if (!_sixIV) {
        _sixIV = [UIImageView new];
        [self.contentView addSubview:_sixIV];
        [_sixIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.firstIV.mas_bottom).offset(7);
            make.left.equalTo(self.firstIV);
            make.height.equalTo(self.sixIV.mas_width).multipliedBy(16 / 9.0);
        }];
    }
    return _sixIV;
}

-(UIImageView *)sevenIV {
    if (!_sevenIV) {
        _sevenIV = [UIImageView new];
        [self.contentView addSubview:_sevenIV];
        [_sevenIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sixIV);
            make.bottom.equalTo(self.sixIV);
            make.left.equalTo(self.sixIV.mas_right).offset(7);
            make.width.equalTo(self.sixIV);
        }];
    }
    return _sevenIV;
}

-(UIImageView *)eightIV {
    if (!_eightIV) {
        _eightIV = [UIImageView new];
        [self.contentView addSubview:_eightIV];
        [_eightIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sevenIV);
            make.bottom.equalTo(self.sevenIV);
            make.left.equalTo(self.sevenIV.mas_right).offset(7);
            make.width.equalTo(self.sevenIV);
        }];
    }
    return _eightIV;
}

-(UIImageView *)nineIV {
    if (!_nineIV) {
        _nineIV = [UIImageView new];
        [self.contentView addSubview:_nineIV];
        [_nineIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.eightIV);
            make.bottom.equalTo(self.eightIV);
            make.left.equalTo(self.eightIV.mas_right).offset(7);
            make.width.equalTo(self.eightIV);
            make.right.equalTo(-7);
        }];
    }
    return _nineIV;
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
