//
//  BaseNetmanager.m
//  极简壁纸
//
//  Created by 璠 王 on 2016/12/18.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import "BaseNetmanager.h"

static BaseNetmanager *afnSingleton = nil;

@interface BaseNetmanager ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation BaseNetmanager

+ (BaseNetmanager *)shareBaseNetManager {
    @synchronized (self) {
        if (afnSingleton == nil) {
            afnSingleton = [[super allocWithZone:nil]init];
            afnSingleton.manager = [AFHTTPSessionManager manager];
        }
    }
    return afnSingleton;
}

+ (id)GET:(NSString *)path parameters:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler{
    //AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [self shareBaseNetManager].manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
    return [[self shareBaseNetManager].manager GET:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"%@", task.currentRequest.URL.absoluteString);
        !completionHandler?:completionHandler(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //NSLog(@"%@", task.currentRequest.URL.absoluteString);
        NSLog(@"%@", error);
        !completionHandler ?: completionHandler(nil, error);
    }];
}


@end
