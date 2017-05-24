//
//  VideoTableViewCell.m
//  demo
//
//  Created by wertyu on 17/5/18.
//  Copyright © 2017年 北京启智. All rights reserved.
//

#import "VideoTableViewCell.h"

@implementation VideoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = RGBCOLOR(246, 246, 246);
        [self SetUpView];
    }
    return self;
}
- (void)SetUpView {
    UIView *backGroundView = [[UIView alloc]init];
    [self.contentView addSubview:backGroundView];
    backGroundView.sd_layout.leftSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).topSpaceToView(self.contentView,0).bottomSpaceToView(self.contentView,15);
    backGroundView.backgroundColor = [UIColor whiteColor];
    
    UILabel *TitleLabel = [[UILabel alloc]init];
    [backGroundView addSubview:TitleLabel];
    TitleLabel.sd_layout.leftSpaceToView(backGroundView,10).rightSpaceToView(backGroundView,10).topSpaceToView(backGroundView,0).heightIs(25);
    self.titleLabel = TitleLabel;
    
    UIImageView *picture = [[UIImageView alloc]init];
    picture.userInteractionEnabled = YES;
    [backGroundView addSubview:picture];
    self.picView.tag = 101;
    self.picView = picture;
    picture.sd_layout.leftSpaceToView(backGroundView,0).rightSpaceToView(backGroundView,0).topSpaceToView(TitleLabel,5).bottomSpaceToView(backGroundView,0);
    
    self.playBtn = [[UIButton alloc]init];
    [picture addSubview:self.playBtn];
    self.playBtn.sd_layout.centerXEqualToView(picture).centerYEqualToView(picture).widthIs(50).heightIs(50);
//    self.playBtn.backgroundColor = [UIColor redColor];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ZFPlayer" ofType:@"bundle"];
    NSString *strC = [[NSBundle bundleWithPath:path] pathForResource:@"ZFPlayer_play_btn@2x" ofType:@"png" inDirectory:nil];
    [self.playBtn setImage:[UIImage imageWithContentsOfFile:strC] forState:UIControlStateNormal];
//    [UIImage imageWithContentsOfFile:strC];

}
- (void)setModel:(VideoModel *)model {
    self.titleLabel.text = model.title;
    [self.picView sd_setImageWithURL:[NSURL URLWithString:model.coverForFeed]];
}
@end
