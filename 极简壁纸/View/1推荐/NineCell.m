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
        [self.contentView addSubview:_secondIV];
        _secondIV.userInteractionEnabled = YES;
        //添加一个手势
        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Push2:)];
        [_secondIV addGestureRecognizer:tapG];
        [_secondIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.firstIV);
            make.left.equalTo(self.firstIV.mas_right).offset(7);
        }];
    }
    return _secondIV;
}
//手势方法
-(void)Push2:sender{
    !_pushBlock2 ?: _pushBlock2(self);
}

-(UIImageView *)thirdIV {
    if (!_thirdIV) {
        _thirdIV = [UIImageView new];
        [self.contentView addSubview:_thirdIV];
        _thirdIV.userInteractionEnabled = YES;
        //添加一个手势
        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Push3:)];
        [_thirdIV addGestureRecognizer:tapG];
        [_thirdIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.secondIV);
            make.left.equalTo(self.secondIV.mas_right).offset(7);
            make.right.equalTo(-7);
            make.width.equalTo(self.secondIV);
        }];
    }
    return _thirdIV;
}
//手势方法
-(void)Push3:sender{
    !_pushBlock3 ?: _pushBlock3(self);
}

-(UIImageView *)fourthIV {
    if (!_fourthIV) {
        _fourthIV = [UIImageView new];
        [self.contentView addSubview:_fourthIV];
        _fourthIV.userInteractionEnabled = YES;
        //添加一个手势
        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Push4:)];
        [_fourthIV addGestureRecognizer:tapG];
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
//手势方法
-(void)Push4:sender{
    !_pushBlock4 ?: _pushBlock4(self);
}

-(UIImageView *)fifthIV {
    if (!_fifthIV) {
        _fifthIV = [UIImageView new];
        [self.contentView addSubview:_fifthIV];
        _fifthIV.userInteractionEnabled = YES;
        //添加一个手势
        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Push5:)];
        [_fifthIV addGestureRecognizer:tapG];
        [_fifthIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.fourthIV);
            make.bottom.equalTo(self.fourthIV);
            make.left.equalTo(self.thirdIV);
            make.right.equalTo(self.thirdIV);
        }];
    }
    return _fifthIV;
}
//手势方法
-(void)Push5:sender{
    !_pushBlock5 ?: _pushBlock5(self);
}

-(UIImageView *)sixIV {
    if (!_sixIV) {
        _sixIV = [UIImageView new];
        [self.contentView addSubview:_sixIV];
        _sixIV.userInteractionEnabled = YES;
        //添加一个手势
        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Push6:)];
        [_sixIV addGestureRecognizer:tapG];
        [_sixIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.firstIV.mas_bottom).offset(7);
            make.left.equalTo(self.firstIV);
            make.height.equalTo(self.sixIV.mas_width).multipliedBy(16 / 9.0);
        }];
    }
    return _sixIV;
}
//手势方法
-(void)Push6:sender{
    !_pushBlock6 ?: _pushBlock6(self);
}

-(UIImageView *)sevenIV {
    if (!_sevenIV) {
        _sevenIV = [UIImageView new];
        [self.contentView addSubview:_sevenIV];
        _sevenIV.userInteractionEnabled = YES;
        //添加一个手势
        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Push7:)];
        [_sevenIV addGestureRecognizer:tapG];
        [_sevenIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sixIV);
            make.bottom.equalTo(self.sixIV);
            make.left.equalTo(self.sixIV.mas_right).offset(7);
            make.width.equalTo(self.sixIV);
        }];
    }
    return _sevenIV;
}
//手势方法
-(void)Push7:sender{
    !_pushBlock7 ?: _pushBlock7(self);
}

-(UIImageView *)eightIV {
    if (!_eightIV) {
        _eightIV = [UIImageView new];
        [self.contentView addSubview:_eightIV];
        _eightIV.userInteractionEnabled = YES;
        //添加一个手势
        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Push8:)];
        [_eightIV addGestureRecognizer:tapG];
        [_eightIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sevenIV);
            make.bottom.equalTo(self.sevenIV);
            make.left.equalTo(self.sevenIV.mas_right).offset(7);
            make.width.equalTo(self.sevenIV);
        }];
    }
    return _eightIV;
}
//手势方法
-(void)Push8:sender{
    !_pushBlock8 ?: _pushBlock8(self);
}

-(UIImageView *)nineIV {
    if (!_nineIV) {
        _nineIV = [UIImageView new];
        [self.contentView addSubview:_nineIV];
        _nineIV.userInteractionEnabled = YES;
        //添加一个手势
        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Push9:)];
        [_nineIV addGestureRecognizer:tapG];
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
//手势方法
-(void)Push9:sender{
    !_pushBlock9 ?: _pushBlock9(self);
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
