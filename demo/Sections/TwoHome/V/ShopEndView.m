//
//  ShopEndView.m
//  demo
//
//  Created by wertyu on 17/5/19.
//  Copyright © 2017年 北京启智. All rights reserved.
//

#import "ShopEndView.h"
#import "Masonry.h"
@interface ShopEndView ()
@property(nonatomic, strong)UIButton *selectButton;   /**< 选择按钮 */
@property(nonatomic, strong)UILabel *priceLabel;   /**< 价格label */
@property(nonatomic, strong)UIButton *settleButton;   /**< 结算按钮 */

@end
@implementation ShopEndView

- (UIButton *)selectButton
{
    if(!_selectButton)
    {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_selectButton setImage:[UIImage imageNamed:@"Unselected"] forState:UIControlStateNormal];
        [_selectButton setImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateSelected];
        [_selectButton setTitle:@"全选" forState:UIControlStateNormal];
        [_selectButton setTitle:@"全选" forState:UIControlStateSelected];
        [_selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        
        _selectButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
        [_selectButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectButton;
}

- (UILabel *)priceLabel
{
    if(!_priceLabel)
    {
        _priceLabel = [[UILabel alloc] init];
        
        _priceLabel.numberOfLines = 0;
        _priceLabel.font = [UIFont systemFontOfSize:14.f];
        _priceLabel.textAlignment = NSTextAlignmentRight;
        _priceLabel.text = @"合计:0.00元\n不含运费和税率";
    }
    return _priceLabel;
}

- (UIButton *)settleButton
{
    if(!_settleButton)
    {
        _settleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _settleButton.backgroundColor = [UIColor colorWithRed:1  green:0.355  blue:0 alpha:1];
        [_settleButton setTitle:@"结算(0)" forState:UIControlStateNormal];
        _settleButton.titleLabel.font = [UIFont systemFontOfSize:13.f];
        [_settleButton addTarget:self action:@selector(settleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _settleButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupSubPageViews];
    }
    return self;
}


- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    
    _selectButton.selected = isSelected;
}

- (void)setTotalPrice:(CGFloat)totalPrice
{
    _totalPrice = totalPrice;
    
    if(totalPrice <= 0.f)
    {
        _priceLabel.text = [NSString stringWithFormat:@"合计:0.00元\n不含运费和税率"];
    }
    else
    {
        _priceLabel.text = [NSString stringWithFormat:@"合计:%.f元\n不含运费和税率",_totalPrice];
        _settleButton.enabled = YES;
    }
}

- (void)setTotalCount:(NSInteger)totalCount
{
    _totalCount = totalCount;
    
    if(_totalCount <= 0)
    {
        [_settleButton setTitle:@"结算(0)" forState:UIControlStateNormal];
        _settleButton.enabled = NO;
    }
    else
    {
        [_settleButton setTitle:[NSString stringWithFormat:@"结算(%ld)",_totalCount] forState:UIControlStateNormal];
        _settleButton.enabled = YES;
    }
}

- (void)selectButtonClick:(UIButton *)selectButton
{
    selectButton.selected = !selectButton.selected;
    
    if(self.allSelectButtonClick)
    {
        self.allSelectButtonClick(selectButton.selected);
    }
    
}

- (void)settleButtonClick:(UIButton *)settleButton
{
    if(self.settleButtonClick)
    {
        self.settleButtonClick();
    }
}

- (void)setupSubPageViews
{
    [self addSubview:self.selectButton];
    [self addSubview:self.priceLabel];
    [self addSubview:self.settleButton];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10 * 2);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(80, 30));
        
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(_settleButton.mas_left).offset(- 10 * 0.5);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.width.equalTo(@120.f);
    }];
    
    [_settleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.right.bottom.equalTo(self);
        
        make.width.equalTo(@100.f);
    }];
}

@end
