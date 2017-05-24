//
//  UIImage+image.m
//  demo
//
//  Created by 北京启智 on 2016/11/19.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import "UIImage+image.h"

@implementation UIImage (image)
+ (UIImage *)imageWithClipeImage:(UIImage *)image border:(CGFloat )borderWidth borderColor:(UIColor *)color {
    CGFloat ovalw = image.size.width + 2 * borderWidth;
    CGFloat ovalH = image.size.height + 2 * borderWidth;
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(ovalw, ovalH), NO, 0);
    //花大圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, ovalw, ovalH)];
    [color set];
    [path fill];
    //设置裁剪区
    UIBezierPath *clipath =  [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderWidth, borderWidth, image.size.width, image.size.height)];
    [clipath addClip];
    //绘制图片
    [image drawAtPoint:CGPointMake(borderWidth, borderWidth)];
    //获取图片
    UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    return clipImage;
}

+ (UIImage *)imageWithCaputuerView:(UIView *)view {
    //开启图片上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    //获取上下文
    CGContextRef ctx  = UIGraphicsGetCurrentContext();
    //把空间渲染到上下文 layer只能渲染，不能绘画
    [view.layer renderInContext:ctx];
    //生成一张图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    return image;
}

@end
