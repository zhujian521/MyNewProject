//
//  StatusesModel.h
//  demo
//
//  Created by 北京启智 on 2016/11/25.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
#import "RetweetStatusModel.h"
@interface StatusesModel : NSObject
@property (nonatomic ,strong)UserModel *user;//用户
@property (nonatomic ,strong)NSString *created_at;// 创建时间
@property (nonatomic ,strong)NSString *text;//内容
@property (nonatomic ,strong)NSString *source;//来源
@property (nonatomic ,strong)NSString *thumbnail_pic;
@property (nonatomic ,strong)NSString *bmiddle_pic;
@property (nonatomic ,strong)NSString *original_pic;
@property (nonatomic ,strong)NSString *reposts_count;//转发
@property (nonatomic ,strong)NSString *comments_count;//评论
@property (nonatomic ,strong)NSString *attitudes_count;//赞
@property (nonatomic ,strong)NSArray *pic_urls;//图片数组
@property (nonatomic ,strong)NSString *id;//微博的标识符
@property (nonatomic ,strong)RetweetStatusModel *retweeted_status;

@end
