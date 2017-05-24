//
//  EmotionContentView.m
//  demo
//
//  Created by lanou3g on 16/12/29.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import "EmotionContentView.h"
#import "EmotionModel.h"
#import "EmotionDetailView.h"
#import "EmotionButton.h"
@interface EmotionContentView ()
@property (nonatomic ,strong)EmotionDetailView *detailView;
@end
@implementation EmotionContentView
- (EmotionDetailView *)detailView {
    if (_detailView == nil) {
        self.detailView = [EmotionDetailView PopEmotion];
    }
    return _detailView;
}
- (void)setPageArr:(NSArray *)pageArr {
   
    _pageArr = pageArr;
    NSUInteger count = pageArr.count;
    for (int i = 0; i < count; i ++) {
        EmotionButton *btn = [[EmotionButton alloc]init];
        EmotionModel *model = pageArr[i];
        btn.model = model;
        if (model.png) {
             [btn setImage:[UIImage imageNamed:model.png] forState:UIControlStateNormal];
        } else if (model.code) {
           NSString *emoji = [model.code emoji];
            [btn setTitle:emoji forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:32];
        }
       
        [self addSubview:btn];
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat inset = 10;
    NSUInteger count = self.pageArr.count;
    CGFloat btnW = (self.width - 2 * inset) / 7;
    CGFloat btnH = (self.height - 2 * inset) / 3;
    for (int i = 0; i < count; i ++) {
        EmotionButton *btn = self.subviews[i];
        btn.width = btnW;
        btn.height = btnH;
        btn.x = inset + (i % 7) * btnW;
        btn.y = inset + (i / 7) * btnH;
        [btn addTarget:self action:@selector(handleDetail:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)handleDetail:(EmotionButton *)sender {
    UIWindow *keyWindow = [[UIApplication sharedApplication].windows lastObject];
    CGRect newFrame = [sender convertRect:sender.bounds toView:keyWindow];
    CGFloat y = CGRectGetMaxY(newFrame);
    CGFloat x = CGRectGetMinX(newFrame);
    [keyWindow addSubview:self.detailView];
    self.detailView.y = y - self.detailView.height - sender.height + 5;
    self.detailView.centerX = sender.centerX;
    if (sender.model.png) {
        [self.detailView.EmotionButton setImage:[UIImage imageNamed:sender.model.png] forState:UIControlStateNormal];
    } else if (sender.model.code) {
        NSString *emoji = [sender.model.code emoji];
        [self.detailView.EmotionButton  setTitle:emoji forState:UIControlStateNormal];
        self.detailView.EmotionButton .titleLabel.font = [UIFont systemFontOfSize:32];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ClikeEmotion" object:self userInfo:@{@"key":sender.model}];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.detailView removeFromSuperview];
    });
  

}
@end
