//
//  PlaceTextView.h
//  demo
//
//  Created by lanou3g on 16/12/7.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EmotionModel;

@interface PlaceTextView : UITextView
@property (nonatomic ,copy)NSString *placeholder;
@property (nonatomic ,strong)UIColor *placeholderColor;
- (void)insertEmotion:(EmotionModel *)emotion;

- (NSString *)fullText;

@end
