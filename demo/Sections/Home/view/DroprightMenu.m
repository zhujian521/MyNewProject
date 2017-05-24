//
//  DroprightMenu.m
//  demo
//
//  Created by 北京启智 on 2016/11/23.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import "DroprightMenu.h"
@interface DroprightMenu ()
/**
 *  将来用来显示具体内容的容器
 */
@property (nonatomic, weak) UIImageView *containerView;

@property (nonatomic, assign)CGFloat tempX;
@end
@implementation DroprightMenu

+ (instancetype)menu {
    
    return [[self alloc]init];
}
- (instancetype)initWithFrame:(CGRect)frame {
   self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (UIImageView *)containerView
{
    if (!_containerView) {
        // 添加一个灰色图片控件
        UIImageView *containerView = [[UIImageView alloc] init];
        containerView.image = [UIImage imageNamed:@"popover_background_right"];
        containerView.userInteractionEnabled = YES; // 开启交互
        [self addSubview:containerView];
        self.containerView = containerView;
    }
    return _containerView;
}
- (void)showFrom:(UIView *)from {
    // 1.获得最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    // 2.添加自己到窗口上
    [window addSubview:self];
    
    // 3.设置尺寸
    self.frame = window.bounds;
    // 4.调整灰色图片的位置
    // 默认情况下，frame是以父控件左上角为坐标原点
    // 转换坐标系
    CGRect newFrame = [from convertRect:from.bounds toView:window];
   
    self.tempX = CGRectGetMaxX(newFrame);
    self.containerView.x = CGRectGetMaxX(newFrame) - self.containerView.width + 10;
    self.containerView.y = CGRectGetMaxY(newFrame);
    
   
}
- (void)setContent:(UIView *)content {
    
    _content = content;
    self.containerView.width = content.width + 20;
    self.containerView.height = content.height + 25;
    self.containerView.x = self.tempX - self.containerView.width + 10;
    // 添加内容到灰色图片中
    [self.containerView addSubview:content];
   
    for (UIButton *tempButton in content.subviews) {
        [tempButton addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    }

}
- (void)dismiss:(UIButton *)sender {
   
    [self dismiss];
     self.rightBlock(sender);
    
}
- (void)dismiss {
    [self removeFromSuperview];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}
@end
