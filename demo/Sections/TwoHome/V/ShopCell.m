//
//  ShopCell.m
//  demo
//
//  Created by wertyu on 17/5/19.
//  Copyright © 2017年 北京启智. All rights reserved.
//

#import "ShopCell.h"
#import "Masonry.h"
#import "ShopCartChangeView.h"
static CGFloat const VIEW_PADDING = 10.f;

@interface ShopCell ()
@property(nonatomic, strong)UIButton *selectButton;   /**< 选择按钮 */
@property(nonatomic, strong)UIImageView *productImageView;   /**< 产品imageView */
@property(nonatomic, strong)UILabel *productLabel;   /**< 产品描述label */
@property(nonatomic, strong)ShopCartChangeView *changeCountView;   /**< 改变数量视图 */
@property(nonatomic, strong)UILabel *stockLabel;   /**< 库存label */
@property(nonatomic, strong)UIView *bottomView;   /**< 底部视图 */

@end
@implementation ShopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//创建
+ (instancetype)shoppingCartCellWithTableView:(UITableView *)tableView
{
    ShopCell *shoppingCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    
    if(shoppingCell == nil)
    {
        shoppingCell = [[ShopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
        
    }
    
    return shoppingCell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.976  green:0.981  blue:0.985 alpha:1];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubPageViews];
    }
    return self;
}
- (void)setupSubPageViews
{
    [self addSubview:self.selectButton];
    [self addSubview:self.productImageView];
    [self addSubview:self.productLabel];
    [self addSubview:self.bottomView];
    [self addSubview:self.changeCountView];
    [self addSubview:self.stockLabel];
}
- (UIImageView *)productImageView
{
    if(!_productImageView)
    {
        _productImageView = [[UIImageView alloc] init];
        
    }
    return _productImageView;
}

- (UILabel *)productLabel
{
    if(!_productLabel)
    {
        _productLabel = [[UILabel alloc] init];
        
        _productLabel.font = [UIFont systemFontOfSize:13.f];
        _productLabel.numberOfLines = 0;
        
    }
    return _productLabel;
}

- (UILabel *)stockLabel
{
    if(!_stockLabel)
    {
        _stockLabel = [[UILabel alloc] init];
        
        _stockLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        _stockLabel.contentMode = UIViewContentModeCenter;
        _stockLabel.font = [UIFont systemFontOfSize:13.f];
    }
    return _stockLabel;
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

- (UIView *)bottomView
{
    if(!_bottomView)
    {
        _bottomView = [[UIView alloc] init];
        
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}
- (ShopCartChangeView *)changeCountView
{
    if(!_changeCountView)
    {
        _changeCountView = [[ShopCartChangeView alloc] init];
        
        __typeof(&*self)weakSelf = self;
        
        _changeCountView.addButtonClick = ^(){
            
            weakSelf.addButtonClick(weakSelf.indexPath);
            
        };
        
        _changeCountView.subButtonClick = ^(){
            
            weakSelf.subButtonClick(weakSelf.indexPath);
            
        };
        
        
    }
    return _changeCountView;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(VIEW_PADDING);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerY.equalTo(self).offset(- 20);
    }];
    
    [_productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_selectButton.mas_right).offset(VIEW_PADDING);
        make.centerY.equalTo(self).offset(- 20);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        
    }];
    
    [_productLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_productImageView.mas_right).offset(VIEW_PADDING);
        make.top.equalTo(self).offset(VIEW_PADDING * 0.5);
        make.right.equalTo(self);
        make.bottom.equalTo(_bottomView.mas_top).offset(- VIEW_PADDING * 0.5);
        
    }];

    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.bottom.right.equalTo(self);
        make.height.equalTo(@40.f);
        
    }];

    [_changeCountView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(VIEW_PADDING);
        make.bottom.equalTo(self).offset(- VIEW_PADDING * 0.5);
        make.size.mas_equalTo(CGSizeMake(120, 30));
    }];
    
    [_stockLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_changeCountView.mas_right).offset(VIEW_PADDING * 2);
        make.size.equalTo(_changeCountView);
        make.centerY.equalTo(_changeCountView);
        
    }];
    
}

- (void)setProductModel:(ProductsModel *)productModel
{
    _productModel = productModel;
    _selectButton.selected = productModel.isSelected;

    [_productImageView sd_setImageWithURL:[NSURL URLWithString:[productModel.productPicUri stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    _productLabel.text = [NSString stringWithFormat:@"%@ %@\n规格: W:%@ H:%@ D:%@\n零售价: %.2f元\n批发价: %.2f元",productModel.brandName, productModel.productNum, productModel.specWidth, productModel.specHeight, productModel.specLength, (float)productModel.originPrice, (float)productModel.productPrice];
    _stockLabel.text = [NSString stringWithFormat:@"库存: %ld",productModel.productStocks];
    
    //计算数量视图需要传入的参数
    _changeCountView.choosedCount = productModel.productQty;
    _changeCountView.totalCount = productModel.productStocks;

}
- (void)selectButtonClick:(UIButton *)selectButton
{
    selectButton.selected = !selectButton.selected;
    
//    self.productModel.isSelected = selectButton.selected;
    
    self.cellSelectedButtonClick(self.indexPath);
}

@end
