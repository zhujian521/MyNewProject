//
//  UIView+add.h
//  demo
//
//  Created by 北京启智 on 2016/11/15.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (add)
//判断手机号码
- (BOOL)isMobileNumber:(NSString *)mobileNum;
//自适应宽和高
- (CGRect )hightForContent:(NSString *)textString textWidth:(CGFloat )textWidth textHight:(CGFloat )textHight textFont:(CGFloat )textFont;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@end
