//
//  VideoTableViewCell.h
//  demo
//
//  Created by wertyu on 17/5/18.
//  Copyright © 2017年 北京启智. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"
@interface VideoTableViewCell : UITableViewCell
@property (weak, nonatomic  ) UIImageView          *picView;
@property (weak, nonatomic  ) UILabel              *titleLabel;
@property (nonatomic ,strong)VideoModel *model;
@property (nonatomic, strong) UIButton  *playBtn;
@end
