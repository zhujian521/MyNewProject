//
//  JHHttpTool.h
//  JGB
//
//  Created by sooyooo on 16/7/26.
//  Copyright © 2016年 sooyooo. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "AFNetworking.h"

/**
 *  发送一个GET请求
 *
 *     请求路径
 *  params  请求参数
 *   success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *   failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
@interface JHHttpTool : NSObject

@property (nonatomic, strong) AFHTTPRequestSerializer *serializer;

+ (void)GET:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObj))success failure:(void (^)(NSError *error))failure;


+ (void)POST:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;


@end
