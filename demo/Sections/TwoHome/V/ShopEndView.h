//
//  ShopEndView.h
//  demo
//
//  Created by wertyu on 17/5/19.
//  Copyright © 2017年 北京启智. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopEndView : UIView
//总价
@property(nonatomic, assign)CGFloat totalPrice;

//总数
@property(nonatomic, assign)NSInteger totalCount;

//是否全选
@property(nonatomic, assign)BOOL isSelected;

//全选
@property(nonatomic, copy)void(^allSelectButtonClick)(BOOL selected);

//结算
@property(nonatomic, copy)void(^settleButtonClick)();
@end
