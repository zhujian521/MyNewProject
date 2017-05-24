//
//  AccountTool.m
//  demo
//
//  Created by 北京启智 on 2016/11/24.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import "AccountTool.h"
#import "AccountModel.h"
#define DocPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"account.data"]
@implementation AccountTool
//存储用户的资料
+ (void)saveAcount:(AccountModel *)account {
    //获取帐号存储的时间
    NSDate *creatTime = [NSDate date];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:creatTime forKey:@"creatTime"];
    [user synchronize];
    
   
    //自定义对象的存储必须用NSKeyedArchiver，不再有什么writeToFile方法
    [NSKeyedArchiver archiveRootObject:account toFile:DocPath];
}
//返回数据
+ (AccountModel *)account {
       AccountModel *model =  [NSKeyedUnarchiver unarchiveObjectWithFile:DocPath];
    //验证帐号是否过期
   long long expires_in = [model.expires_in longLongValue];
     NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
   NSDate *creatTime = [user objectForKey:@"creatTime"];
   NSDate *expires_inTime = [creatTime dateByAddingTimeInterval:expires_in];
    //当前时间
    NSDate *now = [NSDate date];
   NSComparisonResult result = [expires_inTime compare:now];
//    {NSOrderedAscending = -1L, 升序 右边大于左边
//    NSOrderedSame,
//    NSOrderedDescending}; 降序 右边小于左边
//     NSLog(@"%@ %@",expires_inTime,now);
//    if (result == NSOrderedDescending || result == NSOrderedSame) {
//        return  nil;
//    }
    
   
    return model;
}
@end
