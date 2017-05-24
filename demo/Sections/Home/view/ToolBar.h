//
//  ToolBar.h
//  demo
//
//  Created by 北京启智 on 2016/11/28.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StatusesModel;

@interface ToolBar : UIView
@property (nonatomic ,strong)UIButton *ShareButton;
@property (nonatomic ,strong)UIButton *CommentButton;
@property (nonatomic ,strong)UIButton *ZanButton;
@property (nonatomic ,strong)StatusesModel *model;
@end
