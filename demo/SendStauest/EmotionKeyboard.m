//
//  EmotionKeyboard.m
//  demo
//
//  Created by lanou3g on 16/12/9.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import "EmotionKeyboard.h"
#import "EmotionListView.h"
#import "EmotionTabBar.h"
#import "EmotionModel.h"
@interface EmotionKeyboard ()<EmotionTabBarDelegate>
@property (nonatomic ,strong) UIView *listview;
@property (nonatomic ,strong) EmotionTabBar *tabbar;
@property (nonatomic ,strong) EmotionListView *recentlistview;
@property (nonatomic ,strong) EmotionListView *defaultlistview;
@property (nonatomic ,strong) EmotionListView *emotionlistview;
@property (nonatomic ,strong) EmotionListView *lxhlistview;
@end
@implementation EmotionKeyboard


- (EmotionListView *)recentlistview {
    if (_recentlistview == nil) {
        self.recentlistview = [[EmotionListView alloc]init];
//        self.recentlistview.backgroundColor = [UIColor orangeColor];
    }
    return _recentlistview;
}
- (EmotionListView *)defaultlistview {
    if (_defaultlistview == nil) {
        self.defaultlistview = [[EmotionListView alloc]init];
//        self.defaultlistview.backgroundColor = [UIColor blueColor];
        [self EmotionTabBardefalut];
    }
    return _defaultlistview;
}
- (EmotionListView *)emotionlistview {
    if (_emotionlistview == nil) {
        self.emotionlistview = [[EmotionListView alloc]init];
//         self.emotionlistview.backgroundColor = [UIColor grayColor];
        [self EmotionTabBarEmotion];
    }
    return _emotionlistview;
}
- (EmotionListView *)lxhlistview {
    if (_lxhlistview == nil) {
        self.lxhlistview = [[EmotionListView alloc]init];
//         self.lxhlistview.backgroundColor = [UIColor blackColor];
        [self EmotionTabBarLXH];
    }
    return _lxhlistview;
}
- (instancetype)initWithFrame:(CGRect)frame {
   self = [super initWithFrame:frame];
    if (self) {
        //表情部分
        UIView *listview = [[UIView alloc]init];
        listview.backgroundColor = [UIColor redColor];
        [self addSubview:listview];
        self.listview = listview;
        
        
        //tabbar
        EmotionTabBar *tabbar = [[EmotionTabBar alloc]init];
        tabbar.backgroundColor = [UIColor clearColor];
        tabbar.delegate = self;
        [self addSubview:tabbar];
        self.tabbar = tabbar;
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.tabbar.height = 37;
    self.tabbar.x = 0;
    self.tabbar.width = WIDTH;
    self.tabbar.y = self.height - self.tabbar.height;
    
    self.listview.x = 0;
    self.listview.y = 0;
    self.listview.width = WIDTH;
    self.listview.height = self.tabbar.y;
    
    UIView *currentView = [self.listview.subviews lastObject];
    currentView.frame = self.listview.bounds;
    
}
#pragma EmotionTabBarDelegate
- (void)handleTool:(EmotionTabBar *)toolBar button:(EmotionTabBarType)index {
    [self.listview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    switch (index) {
        case EmotionTabBarZui: {
            NSLog(@"最近");
            [self.listview addSubview:self.recentlistview];
            break;
        }
        case EmotionTabBarEmotion: {
             NSLog(@"EmotionTabBarEmotion");
            [self.listview addSubview:self.emotionlistview];
            break;
        }
        case EmotionTabBarDefalut: {
              NSLog(@"EmotionTabBarDefalut");
              [self.listview addSubview:self.defaultlistview];
            break;
        }
        case EmotionTabBarLXH: {
             NSLog(@"EmotionTabBarLXH");
              [self.listview addSubview:self.lxhlistview];
            break;
        }
    }
    [self setNeedsLayout];
}
- (void)EmotionTabBarEmotion {
   NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
   NSArray *emotionArr = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *emotionModelArr = [NSMutableArray array];
    for (NSDictionary *temp in emotionArr) {
        EmotionModel *model = [EmotionModel mj_objectWithKeyValues:temp];
        [emotionModelArr addObject:model];
    }
   
    self.emotionlistview.motionArr = [emotionModelArr copy];
}
- (void)EmotionTabBarLXH {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
    NSArray *emotionArr = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *emotionModelArr = [NSMutableArray array];
    for (NSDictionary *temp in emotionArr) {
        EmotionModel *model = [EmotionModel mj_objectWithKeyValues:temp];
        [emotionModelArr addObject:model];
    }
   
     self.lxhlistview.motionArr = [emotionModelArr copy];
}
- (void)EmotionTabBardefalut {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
    NSArray *emotionArr = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *emotionModelArr = [NSMutableArray array];
    for (NSDictionary *temp in emotionArr) {
        EmotionModel *model = [EmotionModel mj_objectWithKeyValues:temp];
        [emotionModelArr addObject:model];
    }
  
     self.defaultlistview.motionArr = [emotionModelArr copy];
}

@end
