//
//  UploadImageTool.h
//  SportJX
//
//  Created by Chendy on 15/12/22.
//  Copyright © 2015年 Chendy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QiniuSDK.h"
#import <UIKit/UIKit.h>
@interface UploadImageTool : NSObject


// 获取七牛上传token
+ (void)getQiniuUploadToken:(void (^)(NSString *token))success failure:(void (^)())failure;
/**
 *  上传图片
 *
 *  @param image    需要上传的image
 *  @param progress 上传进度block
 *  @param success  成功block 返回url地址
 *  @param failure  失败block
 */
+ (void)uploadImage:(UIImage *)image progress:(QNUpProgressHandler)progress success:(void (^)(NSString *url))success failure:(void (^)())failure;

// 上传多张图片,按队列依次上传
+ (void)uploadImages:(NSArray *)imageArray progress:(void (^)(CGFloat))progress success:(void (^)(NSArray *))success failure:(void (^)())failure;

//上传视频
+ (void)uploadFile:(NSString *)file progress:(QNUpProgressHandler)progress complete:(void (^)(QNResponseInfo *, NSString *, NSDictionary *))complete;




@end
