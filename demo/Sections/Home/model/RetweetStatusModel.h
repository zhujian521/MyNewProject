//
//  RetweetStatusModel.h
//  demo
//
//  Created by 北京启智 on 2016/11/28.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
@interface RetweetStatusModel : NSObject
@property (nonatomic ,strong)NSArray *pic_urls;
@property (nonatomic ,strong)NSString *text;
@property (nonatomic ,strong)UserModel *user;

@end
