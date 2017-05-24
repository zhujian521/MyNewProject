//
//  MineOneTableViewCell.m
//  demo
//
//  Created by 北京启智 on 2016/11/24.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import "MineOneTableViewCell.h"

@implementation MineOneTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self setUpview];
    }
    return self;
}
- (void)setUpview {
    UIView *DowncontentView = [[UIView alloc]init];
    [self.contentView addSubview:DowncontentView];
    DowncontentView.sd_layout.leftSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).topSpaceToView(self.contentView,0).bottomSpaceToView(self.contentView,0);
    
    self.leftPicture = [[UIImageView alloc]init];
    [DowncontentView addSubview:self.leftPicture];
    self.leftPicture.sd_layout.centerYEqualToView(DowncontentView).widthIs(25).heightIs(25).leftSpaceToView(DowncontentView,20);
    
    
    self.titleLabel = [[UILabel alloc]init];
    [DowncontentView addSubview:self.titleLabel];
    self.titleLabel.sd_layout.leftSpaceToView(self.leftPicture,10).centerYEqualToView(self.leftPicture).widthIs(50).heightIs(25);
    self.titleLabel.text = @"hehdh";
     self.titleLabel.font = [UIFont systemFontOfSize:15];
    
    self.titleLable2 = [[UILabel alloc]init];
    [DowncontentView addSubview:self.titleLable2];
    self.titleLable2.sd_layout.centerYEqualToView(self.titleLabel).leftSpaceToView(self.titleLabel,10).widthIs(100).heightIs(25);
    self.titleLable2.textColor = [UIColor grayColor];
    self.titleLable2.font = [UIFont systemFontOfSize:13];
    self.titleLable2.text = @"dwww";
    
}
- (void)configureCellPicturePath:(NSString *)picture titleLabel:(NSString *)titleLabel titleLable2:(NSString *)titleLable2 {
    self.leftPicture.image = [UIImage imageNamed:picture];
    self.titleLabel.text = titleLabel;
    self.titleLabel.sd_layout.widthIs([self hightForContent:titleLabel textWidth:WIDTH textHight:25 textFont:15].size.width);
    if (titleLable2 == nil) {
        self.titleLable2.text = @"";
        self.titleLable2.sd_layout.widthIs(0);
    } else {
        self.titleLable2.text = titleLable2;
        self.titleLable2.sd_layout.widthIs([self hightForContent:titleLable2 textWidth:WIDTH textHight:25 textFont:13].size.width);
    }
   
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
