//
//  MainViewController.h
//  demo
//
//  Created by 北京启智 on 2016/11/21.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UITabBarController
@property (nonatomic ,strong)NSMutableArray *childArr;
@property (nonatomic ,weak)UIView * downView;
@property (nonatomic ,weak)UIView * bgView;

@end
