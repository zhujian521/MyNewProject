//
//  DropdownMenu.h
//  demo
//
//  Created by 北京启智 on 2016/11/23.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DropdownMenu;
@protocol DropdownMenuDelegate <NSObject>

@optional
- (void)dropdownMenuDidDismiss:(DropdownMenu *)menu;
- (void)dropdownMenuDidShow:(DropdownMenu *)menu;
- (void)dropdownMenuDidDeDismiss:(DropdownMenu *)menu titleLabel:(NSString *)titleLabel;

@end
@interface DropdownMenu : UIView
@property (nonatomic, weak) id<DropdownMenuDelegate> delegate;
+ (instancetype)menu;
/**
 *  显示
 */
- (void)showFrom:(UIView *)from;
/**
 *  销毁
 */
- (void)dismiss;

/**
 *  内容
 */
@property (nonatomic, strong) UIView *content;
/**
 *  内容控制器
 */
@property (nonatomic, strong) UIViewController *contentController;
@end
