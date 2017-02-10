//
//  FiveCell.m
//  极简壁纸
//
//  Created by 璠 王 on 2016/12/20.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import "FiveCell.h"

@implementation FiveCell

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
        _thirdIV.contentMode = UIViewContentModeScaleAspectFill;
        _thirdIV.clipsToBounds = YES;
        [self.contentView addSubview:_thirdIV];
        _thirdIV.userInteractionEnabled = YES;
        //添加一个手势
        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Push3:)];
        [_thirdIV addGestureRecognizer:tapG];
        
        [_thirdIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.secondIV.mas_right).offset(7);
            make.top.equalTo(self.secondIV);
            make.right.equalTo(-7);
            make.width.equalTo(self.secondIV);
            make.height.equalTo(self.secondIV);
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
        _fourthIV.contentMode = UIViewContentModeScaleAspectFill;
        _fourthIV.clipsToBounds = YES;
        [self.contentView addSubview:_fourthIV];
        _fourthIV.userInteractionEnabled = YES;
        //添加一个手势
        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Push4:)];
        [_fourthIV addGestureRecognizer:tapG];
        
        [_fourthIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.secondIV);
            make.bottom.equalTo(self.firstIV);
            make.top.equalTo(self.secondIV.mas_bottom).offset(7);
            make.height.equalTo(self.secondIV);
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
        _fifthIV.contentMode = UIViewContentModeScaleAspectFill;
        _fifthIV.clipsToBounds = YES;
        [self.contentView addSubview:_fifthIV];
        _fifthIV.userInteractionEnabled = YES;
        //添加一个手势
        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Push5:)];
        [_fifthIV addGestureRecognizer:tapG];
        
        [_fifthIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.thirdIV);
            make.top.bottom.equalTo(self.fourthIV);
        }];
    }
    return _fifthIV;
}
//手势方法
-(void)Push5:sender{
    !_pushBlock5 ?: _pushBlock5(self);
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
