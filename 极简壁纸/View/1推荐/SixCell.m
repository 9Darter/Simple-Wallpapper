//
//  SixCell.m
//  极简壁纸
//
//  Created by tarena1 on 2016/12/21.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import "SixCell.h"

@implementation SixCell

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
            make.bottom.equalTo(self.firstIV);
            make.left.equalTo(self.firstIV.mas_right).offset(7);
            make.right.equalTo(-7);
        }];
    }
    return _secondIV;
}

-(UIImageView *)thirdIV {
    if (!_thirdIV) {
        _thirdIV = [UIImageView new];
        [self.contentView addSubview:_thirdIV];
        [_thirdIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.firstIV.mas_bottom).offset(7);
            make.left.equalTo(self.firstIV);
            make.height.equalTo(self.thirdIV.mas_width).multipliedBy(16 / 9.0);
        }];
    }
    return _thirdIV;
}

-(UIImageView *)fourthIV {
    if (!_fourthIV) {
        _fourthIV = [UIImageView new];
        [self.contentView addSubview:_fourthIV];
        [_fourthIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.thirdIV);
            make.bottom.equalTo(self.thirdIV);
            make.left.equalTo(self.thirdIV.mas_right).offset(7);
            make.width.equalTo(self.thirdIV);
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
            make.left.equalTo(self.fourthIV.mas_right).offset(7);
            make.width.equalTo(self.fourthIV);
        }];
    }
    return _fifthIV;
}

-(UIImageView *)sixIV {
    if (!_sixIV) {
        _sixIV = [UIImageView new];
        [self.contentView addSubview:_sixIV];
        [_sixIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.fifthIV);
            make.bottom.equalTo(self.fifthIV);
            make.left.equalTo(self.fifthIV.mas_right).offset(7);
            make.width.equalTo(self.fifthIV);
            make.right.equalTo(-7);
        }];
    }
    return _sixIV;
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
