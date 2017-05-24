//
//  EmotionDetailView.h
//  demo
//
//  Created by 北京启智 on 2017/1/2.
//  Copyright © 2017年 北京启智. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmotionDetailView : UIView
@property (nonatomic ,strong)UIImageView *pictureImage;
@property (nonatomic ,strong)UIButton *btn;
@property (strong, nonatomic) IBOutlet UIButton *EmotionButton;
+ (instancetype)PopEmotion;
@end
