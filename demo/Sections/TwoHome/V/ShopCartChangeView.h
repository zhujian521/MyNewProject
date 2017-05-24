//
//  ShopCartChangeView.h
//  demo
//
//  Created by wertyu on 17/5/19.
//  Copyright © 2017年 北京启智. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCartChangeView : UIView
@property(nonatomic, assign)NSInteger choosedCount;   /**< 当前选择个数*/
@property(nonatomic, assign)NSInteger totalCount;   /**< 当前产品的库存总数*/
@property(nonatomic, copy)void(^addButtonClick)();   /**< 加 */
@property(nonatomic, copy)void(^subButtonClick)();   /**< 减 */

@end
