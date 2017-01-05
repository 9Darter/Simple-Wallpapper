//
//  NineCell.h
//  极简壁纸
//
//  Created by tarena1 on 2016/12/21.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NineCell : UITableViewCell
@property(nonatomic, strong) UIImageView *firstIV;
@property(nonatomic, strong) UIImageView *secondIV;
@property(nonatomic, strong) UIImageView *thirdIV;
@property(nonatomic, strong) UIImageView *fourthIV;
@property(nonatomic, strong) UIImageView *fifthIV;
@property(nonatomic, strong) UIImageView *sixIV;
@property(nonatomic, strong) UIImageView *sevenIV;
@property(nonatomic, strong) UIImageView *eightIV;
@property(nonatomic, strong) UIImageView *nineIV;

//给每个imageView单独设置了点击手势，每个手势触发的方法为block，单独设置
@property (nonatomic, copy) void(^pushBlock1)(NineCell *vc);
@property (nonatomic, copy) void(^pushBlock2)(NineCell *vc);
@property (nonatomic, copy) void(^pushBlock3)(NineCell *vc);
@property (nonatomic, copy) void(^pushBlock4)(NineCell *vc);
@property (nonatomic, copy) void(^pushBlock5)(NineCell *vc);
@property (nonatomic, copy) void(^pushBlock6)(NineCell *vc);
@property (nonatomic, copy) void(^pushBlock7)(NineCell *vc);
@property (nonatomic, copy) void(^pushBlock8)(NineCell *vc);
@property (nonatomic, copy) void(^pushBlock9)(NineCell *vc);
@end
