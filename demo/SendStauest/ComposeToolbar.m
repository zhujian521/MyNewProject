//
//  ComposeToolbar.m
//  demo
//
//  Created by lanou3g on 16/12/7.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import "ComposeToolbar.h"

@interface ComposeToolbar ()
@property (nonatomic ,strong)UIButton *keyboardButton;
@end

@implementation ComposeToolbar

- (instancetype)initWithFrame:(CGRect)frame {
   self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        [self setupBtn:@"compose_camerabutton_background" highImage:@"compose_camerabutton_background_highlighted"type:ComposeToolbarCamera];
        
          [self setupBtn:@"compose_toolbar_picture" highImage:@"compose_toolbar_picture_highlighted"type:ComposeToolbarPicture];
        
          [self setupBtn:@"compose_mentionbutton_background" highImage:@"compose_mentionbutton_background_highlighted"type:ComposeToolbarAt];
            [self setupBtn:@"compose_trendbutton_background" highImage:@"compose_trendbutton_background_highlighted"type:ComposeToolbarTrend];
        
      self.keyboardButton =  [self setupBtn:@"compose_emoticonbutton_background" highImage:@"compose_emoticonbutton_background_highlighted"type:ComposeToolbarEmotion];
        
//        [self setupBtn:@"compose_keyboardbutton_background" highImage:@"compose_keyboardbutton_background_highlighted"];
        
      
        
      
        

        
        
    }
    return self;
    
}
- (void)setShowKeyBoard:(BOOL)showKeyBoard {
    _showKeyBoard = showKeyBoard;
    if (showKeyBoard) {
        [self.keyboardButton setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
        [self.keyboardButton setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateHighlighted];
    } else {
        [self.keyboardButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
        [self.keyboardButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }
}
- (UIButton *)setupBtn:(NSString *)image highImage:(NSString *)highImage type:(ComposeToolbarType )type {
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];;
    btn.tag = type;
    [btn addTarget:self action:@selector(handleToolButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    return btn;
    
}
- (void)handleToolButton:(UIButton *)sender {
    ComposeToolbarType type = (ComposeToolbarType )sender.tag;
    if ([self.delegate respondsToSelector:@selector(handleTool:button:)]) {
        [self.delegate handleTool:self button:type];
    }
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    NSUInteger cout = self.subviews.count;
    CGFloat btnW = WIDTH / cout;
    for (NSUInteger i = 0; i < cout; i++) {
        UIButton *btn = self.subviews[i];
        btn.y = 0;
        btn.width = btnW;
        btn.x = i * btnW;
        btn.height = self.height;
        
        
    }
}
@end
