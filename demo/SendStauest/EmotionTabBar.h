//
//  EmotionTabBar.h
//  demo
//
//  Created by lanou3g on 16/12/9.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EmotionButton;

typedef enum {
    EmotionTabBarZui,
    EmotionTabBarDefalut,
    EmotionTabBarEmotion,
    EmotionTabBarLXH
}EmotionTabBarType;
@class EmotionTabBar;
@protocol EmotionTabBarDelegate <NSObject>

@optional
- (void)handleTool:(EmotionTabBar *)toolBar button:(EmotionTabBarType )index;
@end
@interface EmotionTabBar : UIView
@property (nonatomic ,strong)EmotionButton *tempButton;
@property (nonatomic ,assign)id<EmotionTabBarDelegate>delegate;
@end
