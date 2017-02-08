//
//  SaveModel.h
//  极简壁纸
//
//  Created by 璠 王 on 2017/2/8.
//  Copyright © 2017年 璠 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveModel : NSObject
@property (nonatomic, copy) NSString *thumb;
@property (nonatomic, copy) NSString *stand;
-(instancetype)initWithThumb:(NSString *)thumbURL andStand:(NSString *)standURL;
@end
