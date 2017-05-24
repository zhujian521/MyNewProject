//
//  CustomTabBar.h
//  demo
//
//  Created by 北京启智 on 2016/11/23.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTabBar : UITabBar
@property (nonatomic, weak) UIButton *plusBtn;
@property (nonatomic, copy)void (^addBlock) (UIButton *btn);
@end
