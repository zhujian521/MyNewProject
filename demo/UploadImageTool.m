//
//  UploadImageTool.m
//  SportJX
//
//  Created by Chendy on 15/12/22.
//  Copyright © 2015年 Chendy. All rights reserved.
//

#import "UploadImageTool.h"
#import "AFNetworking.h"
#import "QiniuUploadHelper.h"
#import "JHHttpTool.h"
#define imageURLL @"http://7xtfmv.com2.z0.glb.clouddn.com/"
@implementation UploadImageTool


#pragma mark - Helpers
//给图片命名

+ (NSString *)getDateTimeString {
    
    NSDateFormatter *formatter;
    NSString        *dateString;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    dateString = [formatter stringFromDate:[NSDate date]];
    
    return dateString;
}


+ (NSString *)randomStringWithLength:(int)len {
    
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i = 0; i<len; i++) {
        
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((int)[letters length])]];
    }
    
    return randomString;
}


//上传单张图片
+ (void)uploadImage:(UIImage *)image progress:(QNUpProgressHandler)progress success:(void (^)(NSString *url))success failure:(void (^)())failure {
    
    [UploadImageTool getQiniuUploadToken:^(NSString *token) {
        
        NSData *data = UIImageJPEGRepresentation(image, 0.01);
        
        if (!data) {
            
            if (failure) {
                
                failure();
            }
            return;
        }
        
        NSString *fileName = [NSString stringWithFormat:@"%@_%@.png", [UploadImageTool getDateTimeString], [UploadImageTool randomStringWithLength:8]];
        
        QNUploadOption *opt = [[QNUploadOption alloc] initWithMime:nil
                                                   progressHandler:progress
                                                            params:nil
                                                          checkCrc:NO
                                                cancellationSignal:nil];
        QNUploadManager *uploadManager = [QNUploadManager sharedInstanceWithConfiguration:nil];
        
        [uploadManager putData:data
                           key:fileName
                         token:token
                      complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                          
                          if (info.statusCode == 200 && resp) {
                              NSString *url= [NSString stringWithFormat:@"%@%@", imageURLL, [resp objectForKey:@"key"]];
                              if (success) {
                                  
                                  success(url);
                              }
                          }
                          else {
                              if (failure) {
                                  
                                  failure();
                              }
                          }
            
        } option:opt];
        
    } failure:^{
        
    }];
    
}

//上传多张图片
+ (void)uploadImages:(NSArray *)imageArray progress:(void (^)(CGFloat))progress success:(void (^)(NSArray *))success failure:(void (^)())failure {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    __block CGFloat totalProgress = 0.0f;
    __block CGFloat partProgress = 1.0f / [imageArray count];
    __block NSUInteger currentIndex = 0;
    
    QiniuUploadHelper *uploadHelper = [QiniuUploadHelper sharedUploadHelper];
    __weak typeof(uploadHelper) weakHelper = uploadHelper;
    
    uploadHelper.singleFailureBlock = ^() {
        failure();
        return;
    };
    uploadHelper.singleSuccessBlock  = ^(NSString *url) {
        [array addObject:url];
        totalProgress += partProgress;
        progress(totalProgress);
        currentIndex++;
        if ([array count] == [imageArray count]) {
            success([array copy]);
            return;
        }
        else {
            NSLog(@"---%ld",(unsigned long)currentIndex);
            
            if (currentIndex<imageArray.count) {
                
                 [UploadImageTool uploadImage:imageArray[currentIndex] progress:nil success:weakHelper.singleSuccessBlock failure:weakHelper.singleFailureBlock];
            }
           
        }
    };
    
    [UploadImageTool uploadImage:imageArray[0] progress:nil success:weakHelper.singleSuccessBlock failure:weakHelper.singleFailureBlock];
}
//上传视频
+ (void)uploadFile:(NSString *)file progress:(QNUpProgressHandler)progress complete:(void (^)(QNResponseInfo *, NSString *, NSDictionary *))complete {
    
    QNUploadOption *opt = [[QNUploadOption alloc] initWithMime:nil
                                               progressHandler:progress
                                                        params:nil
                                                      checkCrc:NO
                                            cancellationSignal:nil];
    
    [UploadImageTool getQiniuUploadTokenss:^(NSString *token,NSString *key) {
        QNUploadManager *uploadManager = [QNUploadManager sharedInstanceWithConfiguration:nil];
        
        [uploadManager putFile:file key:key token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
            if (complete) {
                complete(info,key,resp);
            }
        } option:opt];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
//上传牛视频的token和filename
+ (void)getQiniuUploadTokenss:(void (^)(NSString *,NSString *))success failure:(void (^)(NSError *))failure {
   
    //        //获取七牛token
        NSString *tokenURL = @"http://orange.webei.cn/api/qiniu/token";
        [JHHttpTool GET:tokenURL params:nil success:^(id responseObj) {
             NSDictionary *dic = responseObj;
            NSLog(@" token字典  dic = %@",dic);
            if (success) {
              
                 success(dic[@"data"][@"token"],dic[@"data"][@"filename"]);
            }
    
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    
    
}
//#error mark -- 必须设置获取七牛token服务器地址,然后获取token返回 --(确认设置后,删除此行)
//获取七牛的token
+ (void)getQiniuUploadToken:(void (^)(NSString *))success failure:(void (^)())failure {
    

    
    //获取七牛token
    NSString *tokenURL = [NSString stringWithFormat:@"%@/v1/list/token",@"https://api.51xuqiubang.com"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"zhujian" forKey:@"appid"];
    
    [JHHttpTool POST:tokenURL params:dic success:^(id responseObj) {
        NSDictionary *dic = responseObj;
        
        
        
        if (success) {
            success([dic objectForKey:@"data"]);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];

    
    
}


@end
