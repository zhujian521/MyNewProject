//
//  UIImage+image.h
//  demo
//
//  Created by 北京启智 on 2016/11/19.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (image)
//图片的裁剪
+ (UIImage *)imageWithClipeImage:(UIImage *)image border:(CGFloat )borderWidth borderColor:(UIColor *)color;
//屏幕截屏
+ (UIImage *)imageWithCaputuerView:(UIView *)view;
@end
