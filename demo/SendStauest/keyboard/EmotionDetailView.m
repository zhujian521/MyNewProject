//
//  EmotionDetailView.m
//  demo
//
//  Created by 北京启智 on 2017/1/2.
//  Copyright © 2017年 北京启智. All rights reserved.
//

#import "EmotionDetailView.h"

@implementation EmotionDetailView

+(instancetype)PopEmotion {
    return [[[NSBundle mainBundle] loadNibNamed:@"EmotionDetailView" owner:nil options:nil] lastObject];
}

@end
