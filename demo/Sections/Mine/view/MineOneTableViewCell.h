//
//  MineOneTableViewCell.h
//  demo
//
//  Created by 北京启智 on 2016/11/24.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineOneTableViewCell : UITableViewCell
@property (nonatomic ,strong)UIImageView *leftPicture;
@property (nonatomic ,strong)UILabel *titleLabel;
@property (nonatomic ,strong)UILabel *titleLable2;
- (void)configureCellPicturePath:(NSString *)picture titleLabel:(NSString *)titleLabel titleLable2:(NSString *)titleLable2;
@end
