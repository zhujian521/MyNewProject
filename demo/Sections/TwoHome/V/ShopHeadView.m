//
//  ShopHeadView.m
//  demo
//
//  Created by wertyu on 17/5/19.
//  Copyright © 2017年 北京启智. All rights reserved.
//

#import "ShopHeadView.h"
#import "Masonry.h"
static CGFloat const HEAD_HEIGHT = 40.f;
static CGFloat const VIEW_PADDING = 5.f;
static CGFloat const VIEW_HEIGHT = 30.f;

@interface ShopHeadView ()
@property(nonatomic, strong)UIButton *selectButton;   /**< 选择按钮 */

@property(nonatomic, strong)UIImageView *bandImageView;   /**< 品牌imageView */

@property(nonatomic, strong)UILabel *bandLabel;   /**< 品牌label */

@end
@implementation ShopHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubPageViews];


    }
    return self;
}
- (void)setupSubPageViews
{
    [self addSubview:self.selectButton];
    [self addSubview:self.bandImageView];
    [self addSubview:self.bandLabel];
}
- (UIButton *)selectButton
{
    if(!_selectButton)
    {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_selectButton setImage:[UIImage imageNamed:@"Unselected"] forState:UIControlStateNormal];
        [_selectButton setImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateSelected];
        
        [_selectButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectButton;
}

- (UIImageView *)bandImageView
{
    if(!_bandImageView)
    {
        _bandImageView = [[UIImageView alloc] init];
        
        _bandImageView.image = [UIImage imageNamed:@"iconfont-SHOP-60x60"];
    }
    return _bandImageView;
}

- (UILabel *)bandLabel
{
    if(!_bandLabel)
    {
        _bandLabel = [[UILabel alloc] init];
        
        _bandLabel.font = [UIFont systemFontOfSize:16.f];
    }
    return _bandLabel;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(VIEW_PADDING);
        make.left.equalTo(self).offset(VIEW_PADDING);
        make.height.equalTo(@(VIEW_HEIGHT));
        make.width.equalTo(_selectButton.mas_height);
    }];
    
    [_bandImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.selectButton.mas_right).offset(VIEW_PADDING * 2);
        make.top.equalTo(self).offset(VIEW_PADDING * 2);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        
    }];
    
    [_bandLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(VIEW_PADDING);
        make.left.equalTo(self.bandImageView.mas_right).offset(VIEW_PADDING * 2);
        make.height.equalTo(@(VIEW_HEIGHT));
        make.width.mas_equalTo(200);
        
    }];
}
- (void)selectButtonClick:(UIButton *)selectButton
{
    selectButton.selected = !selectButton.selected;
    
//    self.model.isSelected = selectButton.selected;
    
    if(self.selectButtonClick)
    {
        self.selectButtonClick(self.section);
    }
    
}
- (void)setModel:(GroupModel *)model {
    self.bandLabel.text = model.brandName;
    self.selectButton.selected = model.isSelected;


}
@end
