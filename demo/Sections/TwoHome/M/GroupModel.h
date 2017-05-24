//
//  GroupModel.h
//  demo
//
//  Created by wertyu on 17/5/19.
//  Copyright © 2017年 北京启智. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupModel : NSObject
@property (nonatomic ,strong)NSString *brandId;
@property (nonatomic ,strong)NSString *brandName;
@property (nonatomic ,strong)NSMutableArray *products;
@property (nonatomic, assign)BOOL isSelected;    //自己添加的属性,用来记录是否选中
@end
