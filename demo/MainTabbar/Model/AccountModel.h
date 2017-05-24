//
//  AccountModel.h
//  demo
//
//  Created by 北京启智 on 2016/11/24.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountModel : NSObject<NSCoding>
@property (nonatomic ,strong)NSString *access_token;
@property (nonatomic ,strong)NSString *expires_in;
@property (nonatomic ,strong)NSString *uid;

@end
