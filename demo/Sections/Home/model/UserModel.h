//
//  UserModel.h
//  demo
//
//  Created by 北京启智 on 2016/11/25.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property (nonatomic ,strong)NSString *name;
@property (nonatomic ,strong)NSString *avatar_hd;
@property (nonatomic ,strong)NSString *profile_image_url;
@property (nonatomic ,strong)NSString *gender;
@property (nonatomic ,strong)NSString *followers_count;//粉丝数
@property (nonatomic ,strong)NSString *friends_count;//关注数
@property (nonatomic ,strong)NSString *statuses_count;//微博数
@property (nonatomic ,strong)NSString *favourites_count;//收藏数
@property (nonatomic ,strong)NSString *location;
@property (nonatomic ,strong)NSString *verified;//是否加v
@property (nonatomic ,strong)NSString *mbrank;
@property (nonatomic ,strong)NSString *mbtype;
@end
