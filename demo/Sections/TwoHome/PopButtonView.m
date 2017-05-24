//
//  PopButtonView.m
//  demo
//
//  Created by wertyu on 17/5/12.
//  Copyright © 2017年 北京启智. All rights reserved.
//

#import "PopButtonView.h"

@implementation PopButtonView

- (instancetype)initWithFrame:(CGRect)frame {
   self = [super initWithFrame:frame];
    if (self) {
        [self setUpButton];
    }
    return self;
}
- (void)setUpButton {
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake( WIDTH ,0, 60, 60)];
    btn1.backgroundColor = [UIColor clearColor];
    [btn1 setImage:[UIImage imageNamed:@"tabbar_compose_camera"] forState:UIControlStateNormal];
    [btn1 setTitle:@"拍照片" forState:UIControlStateNormal];
    [self addSubview:btn1];
    btn1.titleEdgeInsets = UIEdgeInsetsMake(0, -200, 0, 0);
    
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH,50, 60, 60)];
    [btn2 setImage:[UIImage imageNamed:@"tabbar_compose_camera"] forState:UIControlStateNormal];
    [btn2 setTitle:@"拍照片" forState:UIControlStateNormal];
    btn2.titleEdgeInsets = UIEdgeInsetsMake(0, -200, 0, 0);
    [self addSubview:btn2];


    

    
    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH ,120, 60, 60)];
    [btn3 setImage:[UIImage imageNamed:@"tabbar_compose_camera"] forState:UIControlStateNormal];
    [btn3 setTitle:@"拍照片" forState:UIControlStateNormal];
    btn3.titleEdgeInsets = UIEdgeInsetsMake(0, -200, 0, 0);

    [self addSubview:btn3];
    
    

    
    UIButton *btn4 = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH ,170, 60, 60)];
    [btn4 setImage:[UIImage imageNamed:@"tabbar_compose_camera"] forState:UIControlStateNormal];
    [btn4 setTitle:@"拍照片" forState:UIControlStateNormal];
    btn4.titleEdgeInsets = UIEdgeInsetsMake(0, -200, 0, 0);

    [self addSubview:btn4];

    [UIView animateWithDuration:0.3 delay:0.05  usingSpringWithDamping:0.7 initialSpringVelocity:15 options:UIViewAnimationOptionCurveLinear animations:^{
        btn1.frame = CGRectMake( WIDTH - 80,0, 60, 60);
    } completion:nil];
    

    [UIView animateWithDuration:0.3 delay:0.05*2  usingSpringWithDamping:0.7 initialSpringVelocity:15 options:UIViewAnimationOptionCurveLinear animations:^{
        btn2.frame = CGRectMake(WIDTH - 150,50, 60, 60);
    } completion:nil];

    [UIView animateWithDuration:0.3 delay:0.05*3  usingSpringWithDamping:0.7 initialSpringVelocity:15 options:UIViewAnimationOptionCurveLinear animations:^{
        btn3.frame = CGRectMake(WIDTH - 150,120, 60, 60);
    } completion:nil];

    [UIView animateWithDuration:0.3 delay:0.05*4  usingSpringWithDamping:0.7 initialSpringVelocity:15 options:UIViewAnimationOptionCurveLinear animations:^{
        btn4.frame = CGRectMake(WIDTH - 80,170, 60, 60);
    } completion:nil];

    
}
@end
