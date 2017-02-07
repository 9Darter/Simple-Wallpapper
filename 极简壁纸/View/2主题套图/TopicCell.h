//
//  TopicCell.h
//  极简壁纸
//
//  Created by tarena1 on 2016/12/21.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopicCell : UITableViewCell
@property(nonatomic, strong) UIImageView *firstIV;
@property(nonatomic, strong) UIImageView *secondIV;
@property(nonatomic, strong) UILabel *freeLb;
@property(nonatomic, strong) UIButton *downloadBtn;

//给每个imageView单独设置了点击手势，每个手势触发的方法为block，单独设置
@property (nonatomic, copy) void(^pushBlock1)(TopicCell *vc);
@property (nonatomic, copy) void(^pushBlock2)(TopicCell *vc);

//每个button的触发方法调用该block
@property (nonatomic, copy) void(^pushBlock3)(TopicCell *vc);
@end
