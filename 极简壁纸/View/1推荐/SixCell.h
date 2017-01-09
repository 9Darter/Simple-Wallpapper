//
//  SixCell.h
//  极简壁纸
//
//  Created by tarena1 on 2016/12/21.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SixCell : UITableViewCell
@property(nonatomic, strong) UIImageView *firstIV;
@property(nonatomic, strong) UIImageView *secondIV;
@property(nonatomic, strong) UIImageView *thirdIV;
@property(nonatomic, strong) UIImageView *fourthIV;
@property(nonatomic, strong) UIImageView *fifthIV;
@property(nonatomic, strong) UIImageView *sixIV;


//给每个imageView单独设置了点击手势，每个手势触发的方法为block，单独设置
@property (nonatomic, copy) void(^pushBlock1)(SixCell *vc);
@property (nonatomic, copy) void(^pushBlock2)(SixCell *vc);
@property (nonatomic, copy) void(^pushBlock3)(SixCell *vc);
@property (nonatomic, copy) void(^pushBlock4)(SixCell *vc);
@property (nonatomic, copy) void(^pushBlock5)(SixCell *vc);
@property (nonatomic, copy) void(^pushBlock6)(SixCell *vc);

@end
