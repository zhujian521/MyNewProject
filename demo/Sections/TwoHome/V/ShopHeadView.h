//
//  ShopHeadView.h
//  demo
//
//  Created by wertyu on 17/5/19.
//  Copyright © 2017年 北京启智. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupModel.h"
@interface ShopHeadView : UIView
@property (nonatomic ,strong)GroupModel *model;
@property(nonatomic, copy)void(^selectButtonClick)(NSInteger section);   /**< 选择按钮点击回调 */
@property(nonatomic, assign)NSInteger section;

@end
