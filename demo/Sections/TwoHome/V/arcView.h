//
//  arcView.h
//  圆弧进度条显示
//
//  Created by yhj on 15/12/10.
//  Copyright © 2015年 QQ:1787354782. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol arcViewDelegate <NSObject>
@optional
- (void)reSetWeight;

@end

@interface arcView : UIView

@property (weak,nonatomic)id<arcViewDelegate> arcDelegate;

@property(nonatomic,assign)int num;

@property(nonatomic,strong)UILabel *numLabel;

@property (nonatomic,strong)UILabel *cyrcleNumbers;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *weightLabel;
@property (strong,nonatomic)UIButton *setWeight;
-(void)change;

@end
