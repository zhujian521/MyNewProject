//
//  EmotionTabBar.m
//  demo
//
//  Created by lanou3g on 16/12/9.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import "EmotionTabBar.h"
#import "EmotionButton.h"
@implementation EmotionTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self =  [super initWithFrame:frame];
    if (self) {
        [self setupBtn:@"最近" type:EmotionTabBarZui];
        self.tempButton = [self setupBtn:@"表情" type:EmotionTabBarDefalut];
         [self setupBtn:@"emotion" type:EmotionTabBarEmotion];
         [self setupBtn:@"浪小花" type:EmotionTabBarLXH];
        
        
    }
    return self;
};
- (EmotionButton *)setupBtn:(NSString *)title type:(EmotionTabBarType )type{
    EmotionButton *btn = [[EmotionButton alloc]init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
    [btn addTarget:self action:@selector(handleSelect:) forControlEvents:UIControlEventTouchDown];
    [btn setBackgroundImage:[UIImage imageNamed:@"compose_emotion_table_left_normal"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"compose_emotion_table_left_selected"] forState:UIControlStateDisabled];
    btn.tag = type;
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
- (void)handleSelect:(EmotionButton *)sender {
    self.tempButton.enabled = YES;
    sender.enabled = NO;
    self.tempButton = sender;
    [self.delegate handleTool:self button:(EmotionTabBarType)sender.tag];
}
- (void)setDelegate:(id<EmotionTabBarDelegate>)delegate {
    _delegate = delegate;
    
        [self handleSelect:[self viewWithTag:EmotionTabBarDefalut]];
    
}
@end
