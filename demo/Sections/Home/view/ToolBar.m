//
//  ToolBar.m
//  demo
//
//  Created by 北京启智 on 2016/11/28.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import "ToolBar.h"
#import "StatusesModel.h"
@implementation ToolBar

//在初始化里不能设置frame，只能添加控件
- (instancetype)initWithFrame:(CGRect)frame {
   self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
         self.ShareButton = [self setupBtn:@"转发" icon:@"timeline_icon_retweet"];
         self.CommentButton = [self setupBtn:@"评论" icon:@"timeline_icon_comment"];
         self.ZanButton = [self setupBtn:@"赞" icon:@"timeline_icon_unlike"];
       
    }
    return self;

}
- (UIButton *)setupBtn:(NSString *)title icon:(NSString *)icon {
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [self addSubview:btn];
    return btn;
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    int count = (int )self.subviews.count;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    for (int i = 0; i < count; i ++) {
        UIButton *btn = self.subviews[i];
        btn.y = 0;
        btn.width = btnW;
        btn.height = btnH;
        btn.x = i * btnW;
    }
}
- (void)setModel:(StatusesModel *)model
{
    if ([model.reposts_count isEqualToString:@"0"]) {
        [self.ShareButton setTitle:@"转发" forState:UIControlStateNormal];
    } else {
        if ([model.reposts_count integerValue] >= 10000) {
            double wan = [model.reposts_count integerValue] / 10000.0;
            [self.ShareButton setTitle:[NSString stringWithFormat:@"%.1f万",wan] forState:UIControlStateNormal];
            
        } else {
            [self.ShareButton setTitle:model.reposts_count forState:UIControlStateNormal];
        }
        
    }
    
    if ([model.comments_count isEqualToString:@"0"]) {
        [self.CommentButton setTitle:@"评论" forState:UIControlStateNormal];
    } else {
        [self.CommentButton setTitle:model.comments_count forState:UIControlStateNormal];
    }
    if ([model.attitudes_count isEqualToString:@"0"]) {
        [self.ZanButton setTitle:@"点赞" forState:UIControlStateNormal];
    } else {
        [self.ZanButton setTitle:model.attitudes_count forState:UIControlStateNormal];
    }
 
}
@end
