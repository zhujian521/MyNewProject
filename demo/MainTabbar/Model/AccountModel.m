//
//  AccountModel.m
//  demo
//
//  Created by 北京启智 on 2016/11/24.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import "AccountModel.h"

@implementation AccountModel

//对象归档沙河的时候调用，目的：在这个方法中说清楚这个对象的哪几个属性要存进沙河
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.expires_in forKey:@"expires_in"];
    [encoder encodeObject:self.uid forKey:@"uid"];
}
//接档的时候调用,从沙河中接档，调用，目的 这个方法说明沙河里的属性改如何解析
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
         self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
         self.uid = [aDecoder decodeObjectForKey:@"uid"];
    }
    return self;
}
@end
