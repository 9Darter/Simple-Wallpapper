//
//  FiveCell.h
//  极简壁纸
//
//  Created by 璠 王 on 2016/12/20.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FiveCell : UITableViewCell
@property(nonatomic, strong) UIImageView *firstIV;
@property(nonatomic, strong) UIImageView *secondIV;
@property(nonatomic, strong) UIImageView *thirdIV;
@property(nonatomic, strong) UIImageView *fourthIV;
@property(nonatomic, strong) UIImageView *fifthIV;

//给每个imageView单独设置了点击手势，每个手势触发的方法为block，单独设置
@property (nonatomic, copy) void(^pushBlock1)(FiveCell *vc);
@property (nonatomic, copy) void(^pushBlock2)(FiveCell *vc);
@property (nonatomic, copy) void(^pushBlock3)(FiveCell *vc);
@property (nonatomic, copy) void(^pushBlock4)(FiveCell *vc);
@property (nonatomic, copy) void(^pushBlock5)(FiveCell *vc);
@end
