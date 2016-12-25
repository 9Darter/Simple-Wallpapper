//
//  PicController.m
//  极简壁纸
//
//  Created by 璠 王 on 2016/12/25.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import "PicController.h"

@interface PicController ()
@property(nonatomic, strong) UIImageView *picIV;
@end

@implementation PicController
#pragma mark - Lazy
-(UIImageView *)picIV {
    if (!_picIV) {
        _picIV = [UIImageView new];
        _picIV.contentMode = UIViewContentModeScaleAspectFill;
        [_picIV setImageURL:self.low.wf_url];
        [self.view addSubview:_picIV];
        [_picIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
    }
    return _picIV;
}

#pragma mark - Life
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.picIV setImageURL:self.stand.wf_url];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
