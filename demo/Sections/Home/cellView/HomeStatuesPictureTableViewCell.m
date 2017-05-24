//
//  HomeStatuesPictureTableViewCell.m
//  demo
//
//  Created by 北京启智 on 2016/11/25.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import "HomeStatuesPictureTableViewCell.h"
#import "StatusesModel.h"
#import "UserModel.h"
#import "ToolBar.h"
#import "StatuesPhotoView.h"
@interface HomeStatuesPictureTableViewCell ()
@property (nonatomic ,strong)UIView *Firstview;
@property (nonatomic ,strong)UIView *Upview;
@property (nonatomic ,strong)UIView *Centerview;
@property (nonatomic ,strong)UIView *Downview;
@property (nonatomic ,strong)ToolBar *toolView;
@end
@implementation HomeStatuesPictureTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
        [self setUpCellView];
    }
    return self;
}
- (void)setUpCellView {
    self.Firstview = [[UIView alloc]init];
    [self.contentView addSubview:self.Firstview];
    self.Firstview.sd_layout.topSpaceToView(self.contentView,5).leftSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).bottomSpaceToView(self.contentView,5);
    self.Firstview.backgroundColor = RGBCOLOR(242, 242, 242);
    
    self.Upview = [[UIView alloc]init];
    [self.Firstview addSubview:self.Upview];
    self.Upview.sd_layout.topSpaceToView(self.Firstview,0).leftSpaceToView(self.Firstview,0).rightSpaceToView(self.Firstview,0).heightIs(60);
    self.Upview.backgroundColor = [UIColor whiteColor];
    
    
    
    self.Centerview = [[UIView alloc]init];
    [self.Firstview addSubview:self.Centerview];
    self.Centerview.sd_layout.topSpaceToView(self.Upview,0).leftSpaceToView(self.Firstview,0).rightSpaceToView(self.Firstview,0).bottomSpaceToView(self.Firstview,50);
    
    
    self.Downview = [[UIView alloc]init];
    [self.Firstview addSubview:self.Downview];
    self.Downview.backgroundColor = [UIColor whiteColor];
    self.Downview.sd_layout.leftSpaceToView(self.Firstview,0).rightSpaceToView(self.Firstview,0).bottomSpaceToView(self.Firstview,0).heightIs(50);
    
    [self setUpview];
    [self setUpCenterview];
    [self setUpDownButton];
}
- (void)setModel:(StatusesModel *)model {
    [self.HeadrImage sd_setImageWithURL:[NSURL URLWithString:model.user.avatar_hd]];
    self.name.text = model.user.name;
    self.name.sd_layout.widthIs([self hightForContent:model.user.name textWidth:WIDTH textHight:20 textFont:15].size.width);
  
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    //如果是真机需要设置locale
    fmt.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];//en_US" 美国时间 zh_CN中国
    
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *createDate = [fmt dateFromString:model.created_at];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *times;
    
    NSDate *now = [NSDate date];
    //日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //    比较两个时间的差值
    NSDateComponents *cmps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond  fromDate:createDate toDate:now options:0];
    // 获取某个时间的年月日时分秒
    NSDateComponents *cmpsCreatTime = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:createDate];
    NSDateComponents *cmpsNow = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:now];
    if (cmpsCreatTime.year == cmpsNow.year) {
        if ([self isYesterDay:createDate]) {
            fmt.dateFormat = @"昨天 HH:mm";
            times = [fmt stringFromDate:createDate];
        } else if ([self isToday:createDate]) {
            if (cmps.hour >= 1) {
                times = [NSString stringWithFormat:@"%ld小时前",(long)cmps.hour];
            } else if (cmps.minute >= 1) {
                
                times = [NSString stringWithFormat:@"%ld分钟前",(long)cmps.minute];
            } else {
                times = [NSString stringWithFormat:@"%ld秒前",(long)cmps.second];
            }
            
        } else {
            fmt.dateFormat = @"MM-dd HH:mm";
            times = [fmt stringFromDate:createDate];
        }
    } else {
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        times = [fmt stringFromDate:createDate];
    }
    
    self.creatTime.text = times;
    self.creatTime.sd_layout.widthIs([self hightForContent:times textWidth:WIDTH textHight:20 textFont:13].size.width);
    
    if (model.source.length > 60) {
        NSString *source = [model.source substringFromIndex:60];
        source = [source stringByReplacingOccurrencesOfString:@"</a>" withString:@""];
        source =  [NSString stringWithFormat:@"来自%@",source];
        self.sourceLabel.text = source;
        self.sourceLabel.sd_layout.widthIs([self hightForContent:source textWidth:WIDTH textHight:20 textFont:13].size.width);
        
    } else {
        self.sourceLabel.text = @"来自微博 weibo.com";
        self.sourceLabel.sd_layout.widthIs([self hightForContent:@"来自微博 weibo.com" textWidth:WIDTH textHight:20 textFont:13].size.width);
    }
    
    self.centerBackImage.sd_layout.heightIs([self hightForContent:model.text textWidth:WIDTH - 50 textHight:HIGHT textFont:15].size.height + 20);
    self.detailLabel.text = model.text;
    self.detailLabel.sd_layout.heightIs([self hightForContent:model.text textWidth:WIDTH - 50 textHight:HIGHT textFont:15].size.height);
    

       self.toolView.model = model;
    
//    if (model.pic_urls.count != 0) {
//        NSMutableArray *picArr = [NSMutableArray array];
//        for (NSDictionary *temp in model.pic_urls) {
//            [picArr addObject:temp[@"thumbnail_pic"]];//
//        }
//        [self.pictureImage sd_setImageWithURL:[NSURL URLWithString:[picArr firstObject]] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
//    }
    self.PhotoView.photoArr = model.pic_urls;
    NSInteger mbrank = [model.user.mbrank integerValue];
    
    //判断等级
    if (mbrank > 2) {
        self.vipimage.hidden = NO;
        NSString *VIpType = [NSString stringWithFormat:@"common_icon_membership_level%@",model.user.mbrank];
        self.vipimage.image = [UIImage imageNamed:VIpType];
        
    } else {
        self.vipimage.hidden = YES;
    }
    //判断是否为v
    if ([model.user.verified isEqualToString:@"1"]) {
        self.Vpicture.hidden = NO;
    } else {
        self.Vpicture.hidden = YES;
    }
 
    
}
- (BOOL )isYesterDay:(NSDate *)date {
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [fmt stringFromDate:date];
    NSString *nowStr = [fmt stringFromDate:now];
    date = [fmt dateFromString:dateStr];
    now = [fmt dateFromString:nowStr];
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calender components: NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date toDate:now options:0];
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
    
}
- (BOOL )isToday:(NSDate *)date {
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [fmt stringFromDate:date];
    NSString *nowStr = [fmt stringFromDate:now];
    return [dateStr isEqualToString:nowStr];
}

- (void)setUpview {
    
    self.HeadrImage = [[UIImageView alloc]init];
    [self.Upview addSubview:self.HeadrImage];
    self.HeadrImage.sd_layout.leftSpaceToView(self.Upview,10).topSpaceToView(self.Upview,10).widthIs(40).heightIs(40);
    self.HeadrImage.layer.masksToBounds = YES;
    self.HeadrImage.layer.cornerRadius = 20;
    
    self.Vpicture = [[UIImageView alloc]init];
    [self.Upview addSubview:self.Vpicture];
    self.Vpicture.sd_layout.leftSpaceToView(self.Upview,40).topSpaceToView(self.Upview,40).widthIs(10).heightIs(10);
    self.Vpicture.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
    
    self.name = [[UILabel alloc]init];
    [self.Upview addSubview:self.name];
    self.name.sd_layout.leftSpaceToView(self.HeadrImage,10).topSpaceToView(self.Upview,10).widthIs(60).heightIs(20);
    self.name.font = [UIFont systemFontOfSize:15];
    self.name.textColor = [UIColor orangeColor];
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightButton setImage:[UIImage imageNamed:@"timeline_icon_more"] forState:UIControlStateNormal];
    [self.Upview addSubview:self.rightButton];
    self.rightButton.sd_layout.topSpaceToView(self.Upview,10).widthIs(20).heightIs(20).rightSpaceToView(self.Upview,10);
    
    self.vipimage = [[UIImageView alloc]init];
    [self.Upview addSubview:self.vipimage];
    self.vipimage.sd_layout.leftSpaceToView(self.name,5).centerYEqualToView(self.name).widthIs(20).heightIs(20);
    self.vipimage.image = [UIImage imageNamed:@"common_icon_membership_level1"];
    
    self.creatTime = [[UILabel alloc]init];
    [self.Upview addSubview:self.creatTime];
    self.creatTime.sd_layout.leftSpaceToView(self.HeadrImage,10).topSpaceToView(self.name,5).heightIs(20).widthIs(80);
    self.creatTime.font = [UIFont systemFontOfSize:13];
    self.creatTime.textColor = [UIColor grayColor];
    
    self.sourceLabel = [[UILabel alloc]init];
    [self.Upview addSubview:self.sourceLabel];
    self.sourceLabel.sd_layout.leftSpaceToView(self.creatTime,10).centerYEqualToView(self.creatTime).heightIs(20).widthIs(60);
    self.sourceLabel.font = [UIFont systemFontOfSize:13];
    self.sourceLabel.textColor = [UIColor grayColor];
}
- (void)setUpDownButton {

    self.toolView = [[ToolBar alloc]init];
    [self.Downview addSubview:self.toolView];
    self.toolView.sd_layout.leftSpaceToView(self.Downview,0).rightSpaceToView(self.Downview,0).topSpaceToView(self.Downview,0).bottomSpaceToView(self.Downview,0);
    
    
}
- (void)setUpCenterview {
    self.centerBackImage = [[UIImageView alloc]init];
    self.centerBackImage.backgroundColor = [UIColor whiteColor];
    [self.Centerview addSubview:self.centerBackImage];
    self.centerBackImage.sd_layout.topSpaceToView(self.Centerview,0).rightSpaceToView(self.Centerview,0).leftSpaceToView(self.Centerview,0).heightIs(10);
    
    self.detailLabel = [[UILabel alloc]init];
    [self.Centerview addSubview:self.detailLabel];
    self.detailLabel.sd_layout.leftSpaceToView(self.Centerview,20).rightSpaceToView(self.Centerview,30).topSpaceToView(self.Centerview,10).heightIs(0);
    self.detailLabel.font = [UIFont systemFontOfSize:15];
    self.detailLabel.numberOfLines = 0;
    

    
    self.PhotoView = [[StatuesPhotoView alloc]init];
    [self.Centerview addSubview:self.PhotoView];
    self.PhotoView.sd_layout.leftSpaceToView(self.Centerview,0).rightSpaceToView(self.Centerview,0).topSpaceToView(self.centerBackImage,5).bottomSpaceToView(self.Centerview,5);
    
    
}

@end
