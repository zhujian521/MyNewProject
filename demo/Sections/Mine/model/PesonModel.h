//
//  PesonModel.h
//  demo
//
//  Created by 北京启智 on 2016/11/24.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PesonModel : NSObject
@property (nonatomic ,strong)NSString *screen_name;
@property (nonatomic ,strong)NSString *name;
@property (nonatomic ,strong)NSString *province;
@property (nonatomic ,strong)NSString *city;
@property (nonatomic ,strong)NSString *location;
@property (nonatomic ,strong)NSString *avatar_hd;
@property (nonatomic ,strong)NSString *url;
@property (nonatomic ,strong)NSString *profile_image_url;
@property (nonatomic ,strong)NSString *gender;
@property (nonatomic ,strong)NSString *followers_count;
@property (nonatomic ,strong)NSString *friends_count;
@property (nonatomic ,strong)NSString *statuses_count;
@property (nonatomic ,strong)NSString *favourites_count;
@property (nonatomic ,strong)NSString *created_at;

@end
