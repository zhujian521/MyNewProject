//
//  HWTitleMenuViewController.h
//  黑马微博2期
//
//  Created by apple on 14-10-8.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HWTitleMenuViewControllerDelegate <NSObject>

@optional
- (void)didHandleRowTitle:(NSString *)titles;

@end
@interface HWTitleMenuViewController : UITableViewController
@property (nonatomic ,assign)id<HWTitleMenuViewControllerDelegate>delegate;
@end
