//
//  AccountTool.h
//  demo
//
//  Created by 北京启智 on 2016/11/24.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AccountModel;
@interface AccountTool : NSObject
+ (void)saveAcount:(AccountModel *)account;
+ (AccountModel *)account;
@end
