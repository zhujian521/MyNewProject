//
//  MineViewController.m
//  demo
//
//  Created by 北京启智 on 2016/11/21.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import "MineViewController.h"
#import "MineOneTableViewCell.h"
#import "PesonModel.h"


@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *tableview;
@property (nonatomic ,strong)UIView *headView;
@end

@implementation MineViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加好友" style:UIBarButtonItemStylePlain target:self action:@selector(AddFrirend)];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(SetUp)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor grayColor]}];
    [self setUpTableview];
    [self requestPersonInformation];
}
- (void)AddFrirend {
    NSLog(@"添加好友");
}
- (void)SetUp {
     NSLog(@"设置");
}
- (void)setUpTableview {
    self.tableview = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableview];
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 150)];
    self.headView.backgroundColor = [UIColor grayColor];
    self.tableview.tableHeaderView = self.headView;
    self.tableview.tableFooterView = [UIView new];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerClass:[MineOneTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self loadHeadView];
    
}
- (void)loadHeadView {
    UIView *UpView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, self.headView.height / 5 * 3 - 1)];
    UIView *DownView =[[UIView alloc]initWithFrame:CGRectMake(0, self.headView.height / 5 * 3, WIDTH, self.headView.height / 5 * 2)];
    [self.headView addSubview:UpView];
    [self.headView addSubview:DownView];
    UpView.backgroundColor = [UIColor whiteColor];
    DownView.backgroundColor = [UIColor whiteColor];
    
    self.picture = [[UIImageView alloc]init];
    [UpView addSubview:self.picture];
    self.picture.sd_layout.leftSpaceToView(UpView,20).centerYEqualToView(UpView).heightIs(self.headView.height / 5 * 3 - 20).widthIs(self.headView.height / 5 * 3 - 20);
    self.picture.layer.masksToBounds = YES;
    self.picture.layer.cornerRadius = (self.headView.height / 5 * 3 - 20) / 2;
   
    
    self.name = [[UILabel alloc]init];
    [UpView addSubview:self.name];
    self.name.sd_layout.leftSpaceToView(self.picture,10).topSpaceToView(UpView,10 + (self.headView.height / 5 * 3 - 20) / 2 - 40).heightIs(25).widthIs(50);
    self.name.font = [UIFont systemFontOfSize:15];
    
    self.introduceLabel = [[UILabel alloc]init];
    self.introduceLabel.textColor = [UIColor lightGrayColor];
    [UpView addSubview:self.introduceLabel];
    self.introduceLabel.sd_layout.leftSpaceToView(self.picture,10).topSpaceToView(self.name,5).heightIs(25).widthIs(WIDTH - 150 - 20 - 10 - (self.headView.height / 5 * 3 - 20));
    self.introduceLabel.font = [UIFont systemFontOfSize:12];
    
    
    
    
    
    UIImageView *rightImage = [[UIImageView alloc]init];
    [UpView addSubview:rightImage];
     rightImage.image = [UIImage imageNamed:@"navigationbar_arrow_up"];
    rightImage.transform = CGAffineTransformMakeRotation(M_PI_2);

    rightImage.sd_layout.rightSpaceToView(UpView,20).widthIs(14 * 14 / 26).heightIs(14).centerYEqualToView(UpView);
    
    self.vipLabel = [[UILabel alloc]init];
    [UpView addSubview:self.vipLabel];
    self.vipLabel.font = [UIFont systemFontOfSize:15];
    self.vipLabel.textColor = [UIColor orangeColor];
    self.vipLabel.sd_layout.rightSpaceToView(rightImage,5).heightIs(25).widthIs( [self.view hightForContent:@"普通用户" textWidth:WIDTH textHight:25 textFont:15].size.width).centerYEqualToView(UpView);
    self.vipLabel.text = @"普通用户";
    
    self.vipImage = [[UIImageView alloc]init];
    [UpView addSubview:self.vipImage];
    self.vipImage.sd_layout.rightSpaceToView(self.vipLabel,5).centerYEqualToView(UpView).widthIs(25).heightIs(25);
    self.vipImage.image = [UIImage imageNamed:@"common_icon_membership_expired"];
   
    self.friends = [[UILabel alloc]init];
    [DownView addSubview:self.friends];
    self.friends.sd_layout.centerXEqualToView(DownView).topSpaceToView(DownView,5).heightIs((self.headView.height / 5 * 2 - 10) / 2).widthIs(60);
    self.friends.font = [UIFont systemFontOfSize:13];
    self.friends.textAlignment = NSTextAlignmentCenter;
    self.friends.text = @"50";
    
    UILabel *label1 = [[UILabel alloc]init];
    [DownView addSubview:label1];
    label1.font = [UIFont systemFontOfSize:13];
    label1.textColor = [UIColor lightGrayColor];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = @"关注";
    label1.sd_layout.centerXEqualToView(self.friends).topSpaceToView(self.friends,0).heightIs((self.headView.height / 5 * 2 - 10) / 2).widthIs(60);
    
    self.followers = [[UILabel alloc]init];
    [DownView addSubview:self.followers];
    self.followers.sd_layout.topSpaceToView(DownView,5).heightIs((self.headView.height / 5 * 2 - 10) / 2).widthIs(60).rightSpaceToView(DownView,10);
    self.followers.font = [UIFont systemFontOfSize:13];
    self.followers.textAlignment = NSTextAlignmentCenter;
    self.followers.text = @"7";
    
    UILabel *label2 = [[UILabel alloc]init];
    [DownView addSubview:label2];
    label2.font = [UIFont systemFontOfSize:13];
    label2.textColor = [UIColor lightGrayColor];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = @"粉丝";
    label2.sd_layout.centerXEqualToView(self.followers).topSpaceToView(self.followers,0).heightIs((self.headView.height / 5 * 2 - 10) / 2).widthIs(60);
    
    
    self.statuses = [[UILabel alloc]init];
    [DownView addSubview:self.statuses];
    self.statuses.sd_layout.topSpaceToView(DownView,5).heightIs((self.headView.height / 5 * 2 - 10) / 2).widthIs(60).leftSpaceToView(DownView,10);
    self.statuses.font = [UIFont systemFontOfSize:13];
    self.statuses.textAlignment = NSTextAlignmentCenter;
    self.statuses.text = @"59";
    
    UILabel *label3 = [[UILabel alloc]init];
    [DownView addSubview:label3];
    label3.font = [UIFont systemFontOfSize:13];
    label3.textColor = [UIColor lightGrayColor];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.text = @"微薄";
    label3.sd_layout.centerXEqualToView(self.statuses).topSpaceToView(self.statuses,0).heightIs((self.headView.height / 5 * 2 - 10) / 2).widthIs(60);
    
    
}
- (void)requestPersonInformation {
    NSString *url = @"https://api.weibo.com/2/users/show.json";
   AccountModel *model = [AccountTool account];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:model.access_token forKey:@"access_token"];
    [dic setObject:model.uid forKey:@"uid"];
    [JHHttpTool GET:url params:dic success:^(id responseObj) {
        NSLog(@"%@",responseObj);
        PesonModel *model =  [PesonModel mj_objectWithKeyValues:responseObj];
        self.name.text = model.name;
        self.name.sd_layout.widthIs([self.view hightForContent:model.name textWidth:WIDTH textHight:25 textFont:15].size.width);
        NSString *imgPath = @"http://120.77.211.200/image/getImg?path=20170405\\101427331\\1os0.png";
        imgPath = [imgPath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
        // 反斜杠处理
        imgPath = [imgPath stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];

        [self.picture sd_setImageWithURL:[NSURL URLWithString:imgPath]];
        self.introduceLabel.text = [NSString stringWithFormat:@"简介:%@",[responseObj objectForKey:@"description"]];
        self.followers.text = model.followers_count;
        self.friends.text = model.friends_count;
        self.statuses.text = model.statuses_count;
        
    } failure:^(NSError *error) {
        
    }];
    
}
#pragma UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0 || section == 2 || section == 3) {
        return 2;
    } else if (section == 1) {
        return 3;
    } else {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   MineOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [cell configureCellPicturePath:@"app" titleLabel:@"签到有礼" titleLable2:@"每日签到，红包多多"];
            
        } else {
            [cell configureCellPicturePath:@"new_friend" titleLabel:@"新的好友" titleLable2:@""];
        }
        
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
             [cell configureCellPicturePath:@"album" titleLabel:@"我的相册" titleLable2:@""];
        } else if (indexPath.row == 1) {
             [cell configureCellPicturePath:@"collect" titleLabel:@"我的点评" titleLable2:@""];
        } else {
             [cell configureCellPicturePath:@"like" titleLabel:@"我的点赞" titleLable2:@""];
        }
        
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            [cell configureCellPicturePath:@"pay" titleLabel:@"微薄钱包" titleLable2:@"充值最高返现2000"];
            
        } else {
            [cell configureCellPicturePath:@"game_center" titleLabel:@"微薄运动" titleLable2:@""];
        }

        
    } else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            [cell configureCellPicturePath:@"cast" titleLabel:@"粉丝头条" titleLable2:@"推广博文及帐号的利器"];
            
        } else {
            [cell configureCellPicturePath:@"find_people" titleLabel:@"粉丝服务" titleLable2:@"数据助手"];
        }

        
    } else if (indexPath.section == 4) {
         [cell configureCellPicturePath:@"draft" titleLabel:@"草稿箱" titleLable2:@""];
    } else {
         [cell configureCellPicturePath:@"more" titleLabel:@"更多" titleLable2:@"文章收藏"];
    }
    return cell;
}
@end
