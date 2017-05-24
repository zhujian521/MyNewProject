//
//  ShopCartChangeView.m
//  demo
//
//  Created by wertyu on 17/5/19.
//  Copyright © 2017年 北京启智. All rights reserved.
//

#import "ShopCartChangeView.h"
#import "Masonry.h"
@interface ShopCartChangeView ()
@property(nonatomic, strong)UIButton *subButton;   /**< 减按钮 */
@property(nonatomic, strong)UIButton *addButton;   /**< 加按钮 */
@property(nonatomic, strong)UITextField *numberTF;   /**< 数字textField */
@end
@implementation ShopCartChangeView

- (UITextField *)numberTF
{
    if(!_numberTF)
    {
        _numberTF = [[UITextField alloc] init];
        
        _numberTF.textAlignment=NSTextAlignmentCenter;
        _numberTF.keyboardType=UIKeyboardTypeNumberPad;
        _numberTF.clipsToBounds = YES;
        _numberTF.enabled = NO;
        _numberTF.layer.borderColor = [[UIColor colorWithRed:0.776  green:0.780  blue:0.789 alpha:1] CGColor];
        _numberTF.layer.borderWidth = 0.5;
//        _numberTF.delegate = self;
        _numberTF.font=[UIFont systemFontOfSize:13];
        _numberTF.backgroundColor = [UIColor whiteColor];
    }
    return _numberTF;
}

- (UIButton *)subButton
{
    if(!_subButton)
    {
        _subButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_subButton setBackgroundImage:[UIImage imageNamed:@"product_detail_sub_normal"] forState:UIControlStateNormal];
        [_subButton setBackgroundImage:[UIImage imageNamed:@"product_detail_sub_no"] forState:UIControlStateDisabled];
        
        [_subButton addTarget:self action:@selector(subButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _subButton;
}

- (UIButton *)addButton
{
    if(!_addButton)
    {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_addButton setBackgroundImage:[UIImage imageNamed:@"product_detail_add_normal"] forState:UIControlStateNormal];
        [_addButton setBackgroundImage:[UIImage imageNamed:@"product_detail_add_no"] forState:UIControlStateDisabled];
        
        [_addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _addButton;
}
- (void)setChoosedCount:(NSInteger)choosedCount
{
    _choosedCount = choosedCount;
    
    //如果当前选择个数小于1
    _choosedCount <= 1 ? (_subButton.enabled = NO) : (_subButton.enabled = YES);
    
    _numberTF.text = [NSString stringWithFormat:@"%ld",_choosedCount];
}

- (void)setTotalCount:(NSInteger)totalCount
{
    _totalCount = totalCount;
    
    //如果当前选择个数大于总库存
    _choosedCount >= _totalCount ? (_addButton.enabled = NO) : (_addButton.enabled = YES);
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupSubPageViews];
        
    }
    return self;
}
- (void)subButtonClick:(UIButton *)subButton
{
    self.subButtonClick();
}

- (void)addButtonClick:(UIButton *)addButton
{
    self.addButtonClick();
}

//- (void)textFieldDidEndEditing:(UITextField *)textField
//{
//    NSInteger changedCount = [textField.text integerValue];
//    self.textEndEdit(changedCount);
//}


- (void)setupSubPageViews
{
    [self addSubview:self.subButton];
    [self addSubview:self.addButton];
    [self addSubview:self.numberTF];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_subButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(self);
        make.width.equalTo(_subButton.mas_height);
        make.top.equalTo(self);
        make.left.equalTo(self);
        
    }];
    
    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(self);
        make.width.equalTo(_subButton.mas_height);
        make.top.equalTo(self);
        make.right.equalTo(self);
        
    }];
    
    
    [_numberTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_subButton.mas_right);
        make.right.equalTo(_addButton.mas_left);
        make.top.bottom.equalTo(self);
        
    }];
}


@end
