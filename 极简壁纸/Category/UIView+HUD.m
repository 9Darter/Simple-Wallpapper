//
//  UIView+HUD.m
//  极简壁纸
//
//  Created by tarena1 on 2017/1/16.
//  Copyright © 2017年 璠 王. All rights reserved.
//

#import "UIView+HUD.h"

@implementation UIView (HUD)
-(void)showMsg:(NSString *)msg autoHideAfterDely:(double)delay {
    //[MBProgressHUD hideAllHUDsForView:self animated:YES];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = msg;
    //    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    //    hud.bezelView.color = [UIColor clearColor];
    if (delay > 0) {
        [hud hideAnimated:YES afterDelay:delay];
    }
}
@end
