//
//  TwoCell.h
//  极简壁纸
//
//  Created by tarena1 on 2016/12/20.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwoCell : UITableViewCell
@property(nonatomic, strong) UIImageView *firstIV;
@property(nonatomic, strong) UIImageView *secondIV;

//给每个imageView单独设置了点击手势，每个手势触发的方法为block，单独设置
@property (nonatomic, copy) void(^pushBlock1)(TwoCell *vc);
@property (nonatomic, copy) void(^pushBlock2)(TwoCell *vc);
@end
