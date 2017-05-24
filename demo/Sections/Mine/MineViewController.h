//
//  MineViewController.h
//  demo
//
//  Created by 北京启智 on 2016/11/21.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineViewController : UIViewController
@property (nonatomic ,strong)UIImageView *picture;
@property (nonatomic ,strong)UILabel *name;
@property (nonatomic ,strong)UILabel *introduceLabel;
@property (nonatomic ,strong)UIImageView *vipImage;
@property (nonatomic ,strong)UILabel *vipLabel;

@property (nonatomic ,strong)UILabel *followers;
@property (nonatomic ,strong)UILabel *friends;
@property (nonatomic ,strong)UILabel *statuses;
@end
