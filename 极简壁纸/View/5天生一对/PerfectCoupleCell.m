//
//  PerfectCoupleCell.m
//  极简壁纸
//
//  Created by 璠 王 on 2016/12/23.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import "PerfectCoupleCell.h"

@implementation PerfectCoupleCell
-(UIImageView *)firstIV {
    if (!_firstIV) {
        _firstIV = [UIImageView new];
        _firstIV.contentMode = UIViewContentModeScaleAspectFill;
        _firstIV.clipsToBounds = YES;
        [self.contentView addSubview:_firstIV];
        CGFloat width = (kScreenWidth - 21) / 2;
        CGFloat height = width * (16 / 9.0);
        _firstIV.userInteractionEnabled = YES;
        //添加一个手势
        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Push1:)];
        [_firstIV addGestureRecognizer:tapG];
        [_firstIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(7);
            make.top.equalTo(10);
            make.width.equalTo(width);
            make.height.equalTo(height);
        }];
    }
    return _firstIV;
}
//手势方法
-(void)Push1:sender{
    !_pushBlock1 ?: _pushBlock1(self);
}

-(UIImageView *)secondIV {
    if (!_secondIV) {
        _secondIV = [UIImageView new];
        _secondIV.contentMode = UIViewContentModeScaleAspectFill;
        _secondIV.clipsToBounds = YES;
        [self.contentView addSubview:_secondIV];
        _secondIV.userInteractionEnabled = YES;
        //添加一个手势
        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Push2:)];
        [_secondIV addGestureRecognizer:tapG];
        [_secondIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-7);
            make.top.bottom.equalTo(self.firstIV);
            make.left.equalTo(self.firstIV.mas_right).offset(7);
        }];
    }
    return _secondIV;
}
//手势方法
-(void)Push2:sender{
    !_pushBlock2 ?: _pushBlock2(self);
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
