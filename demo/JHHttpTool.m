//
//  JHHttpTool.m
//  JGB
//
//  Created by sooyooo on 16/7/26.
//  Copyright © 2016年 sooyooo. All rights reserved.
//

#import "JHHttpTool.h"
#import "AFNetworking.h"

#import <Foundation/Foundation.h>


@implementation JHHttpTool





+ (void)GET:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    
    
    //1.获得请求管理者
    AFHTTPSessionManager  *manger = [AFHTTPSessionManager manager];
    
    
    [manger GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
}


+ (void)POST:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    //1.获得请求管理者
    AFHTTPSessionManager  *manger = [AFHTTPSessionManager manager];
    
    [manger POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }

    }];
    
    
}


@end
