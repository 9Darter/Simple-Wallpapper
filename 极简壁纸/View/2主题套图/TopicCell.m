//
//  TopicCell.m
//  极简壁纸
//
//  Created by tarena1 on 2016/12/21.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import "TopicCell.h"

@implementation TopicCell

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
            make.right.equalTo(-7);
            make.top.bottom.equalTo(self.firstIV);
            make.left.equalTo(self.firstIV.mas_right).offset(7);
        }];
    }
    return _secondIV;
}

-(UILabel *)freeLb {
    if (!_freeLb) {
        _freeLb = [UILabel new];
        _freeLb.font = [UIFont systemFontOfSize:14];
        _freeLb.textColor = [UIColor colorWithRed:208 / 255.0 green:0 blue:0 alpha:1];
        [self.contentView addSubview:_freeLb];
        [_freeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.firstIV);
            make.top.equalTo(self.firstIV.mas_bottom).offset(23);
        }];
    }
    return _freeLb;
}

-(UIButton *)downloadBtn {
    if (!_downloadBtn) {
        _downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _downloadBtn.layer.cornerRadius = 2;
        _downloadBtn.clipsToBounds = YES;
        _downloadBtn.backgroundColor = [UIColor colorWithRed:212 / 255.0 green:41 / 255.0 blue:53 / 255.0 alpha:1];
        _downloadBtn.titleLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_downloadBtn];
        [_downloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.secondIV);
            make.top.equalTo(self.secondIV.mas_bottom).offset(17);
            make.width.equalTo(100);
            make.height.equalTo(27);
        }];
    }
    return _downloadBtn;
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
