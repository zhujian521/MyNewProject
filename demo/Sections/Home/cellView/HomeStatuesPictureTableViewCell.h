//
//  HomeStatuesPictureTableViewCell.h
//  demo
//
//  Created by 北京启智 on 2016/11/25.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StatusesModel;
@class StatuesPhotoView;
@interface HomeStatuesPictureTableViewCell : UITableViewCell
@property (nonatomic ,strong)UIImageView *HeadrImage;
@property (nonatomic ,strong)UILabel *name;
@property (nonatomic ,strong)UILabel *creatTime;
@property (nonatomic ,strong)UILabel *sourceLabel;
@property (nonatomic ,strong)UIImageView *vipimage;
@property (nonatomic ,strong)UIButton *rightButton;
@property (nonatomic ,strong)UIImageView *centerBackImage;
@property (nonatomic ,strong)UILabel *detailLabel;
@property (nonatomic ,strong)UIImageView *Vpicture;
@property (nonatomic ,strong)StatusesModel *model;
@property (nonatomic ,strong)StatuesPhotoView *PhotoView;
@end
