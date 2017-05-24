//
//  ShopCell.h
//  demo
//
//  Created by wertyu on 17/5/19.
//  Copyright © 2017年 北京启智. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductsModel.h"
@interface ShopCell : UITableViewCell
//初始化
+ (instancetype)shoppingCartCellWithTableView:(UITableView *)tableView;
@property(nonatomic, strong)NSIndexPath *indexPath;   /**< cell的index */
@property(nonatomic, strong)ProductsModel *productModel;   /**< 产品model */
@property(nonatomic, copy)void(^addButtonClick)(NSIndexPath *index);   /**< 加 */
@property(nonatomic, copy)void(^subButtonClick)(NSIndexPath *index);   /**< 减 */
@property(nonatomic, copy)void(^cellSelectedButtonClick)(NSIndexPath *index);   /**< cell选中按钮点击回调 */
@end
