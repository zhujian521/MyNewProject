//
//  HomeViewController.m
//  demo
//
//  Created by 北京启智 on 2016/11/21.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import "HomeViewController.h"
#import "DropdownMenu.h"
#import "DroprightMenu.h"
#import "HWTitleMenuViewController.h"
#import "StatusesModel.h"
#import "UserModel.h"
#import "HomeStatesTableViewCell.h"
#import "HomeStatuesPictureTableViewCell.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "SRActionSheet.h"
#import "lhScanQCodeViewController.h" //二维码

@interface HomeViewController ()<DropdownMenuDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UIView *rightView;
@property (nonatomic ,strong)NSMutableArray *dateArr;
@property (nonatomic ,strong)UITableView *tableview;
@property (nonatomic ,assign)NSInteger currentPage;
@property (nonatomic ,strong)NSMutableArray *idArr;

@end
bool ishead;
@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(242, 242, 242);
    self.dateArr = [NSMutableArray array];
    self.idArr = [NSMutableArray array];
    self.currentPage = 1;
    [self setTabbarButton];
    [self setUpNavigationTitle:@"@泡沫"];
    [self setUpTableview];
    [self requestDateMain];
   NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(setUpUnreadCount) userInfo:nil repeats:YES];
    //当tableview滑动的时候主线程是忽略定时器的作用，此时需要让主线程抽出时间去处理下定时器
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
   
    
    
}
- (void)setUpTableview {
    self.tableview = [[UITableView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.tableview];
    self.tableview.tableFooterView = [UIView new];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    self.tableview.backgroundColor = [UIColor clearColor];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerClass:[HomeStatesTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableview registerClass:[HomeStatuesPictureTableViewCell class] forCellReuseIdentifier:@"picture"];
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.currentPage = 1;
        ishead = NO;
        [self requestDateMain];
    }];
    MJRefreshAutoGifFooter *footer  = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
            self.currentPage ++;
            ishead = YES;
            [self requestDateMain];
    }];
    self.tableview.mj_footer = footer;
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载中" forState:MJRefreshStatePulling];
    [footer setTitle:@"正在加载中" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多数据" forState:MJRefreshStateNoMoreData];
   // self.tableview.contentInset = UIEdgeInsetsMake(5, 0, 0, 0);

}
- (void)setUpNavigationTitle:(NSString *)title {
    UIButton *titleButton = [[UIButton alloc]init];
    titleButton.width = 150;
    titleButton.height = 30;
    titleButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [titleButton setTitle:title forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    CGRect rect = [self.view hightForContent:title textWidth:WIDTH textHight:21.6 textFont:17];
    titleButton.titleLabel.width = rect.size.width;
    NSLog(@"%@ %@",NSStringFromCGRect(titleButton.titleLabel.frame),NSStringFromCGRect(titleButton.imageView.frame));
    
    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, rect.size.width + titleButton.titleLabel.origin.x , 0, 0);
    [titleButton addTarget:self action:@selector(handleTitle:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
}
- (void)handleTitle:(UIButton *)sender {
    DropdownMenu *menu = [DropdownMenu menu];
    menu.delegate = self;
    // 2.设置内容
    HWTitleMenuViewController *vc = [[HWTitleMenuViewController alloc] init];
    vc.view.height = 300;
    vc.view.width =  220;
    menu.contentController = vc;
    [menu showFrom:sender];
    
}
- (void)setTabbarButton {
    /* 设置导航栏上面的内容 */
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(handleLeftAction) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(handleRightAction:) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
}
- (void)handleLeftAction {

}
- (void)handleRightAction:(UIButton *)sender {

    DroprightMenu *menu = [DroprightMenu menu];
    self.rightView = [[UIView alloc]init];
     self.rightView.width = 150;
     self.rightView.height = 100;
     self.rightView.x = 10;
     self.rightView.y = 15;
    [self setUpRightButton];
    menu.content =  self.rightView;
//    __weak typeof(self)weakself = self;
    
    [menu showFrom:sender];
    menu.rightBlock = ^(UIButton *sender) {
        if ([sender.titleLabel.text isEqualToString:@"扫一扫"]) {
            lhScanQCodeViewController * sqVC = [[lhScanQCodeViewController alloc]init];
            UINavigationController * nVC = [[UINavigationController alloc]initWithRootViewController:sqVC];
            [self presentViewController:nVC animated:YES completion:^{
                
            }];
 
            
        } else {
            SHOW_ALERT22(sender.titleLabel.text);

        }
    };
}
- (void)setUpRightButton {

    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
   [self.rightView addSubview:btn1];
   btn1.sd_layout.rightSpaceToView(self.rightView,5).topSpaceToView(self.rightView,5).rightSpaceToView(self.rightView,5).heightIs(30);
  
    [btn1 setImage:[UIImage imageNamed:@"navigationbar_pop"] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] forState:UIControlStateHighlighted];
    [btn1 setTitle:@"扫一扫" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn1.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    btn1.titleLabel.textAlignment = NSTextAlignmentLeft;
    btn1.tag = 1000;

    
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightView addSubview:btn2];
    btn2.sd_layout.rightSpaceToView(self.rightView,5).topSpaceToView(btn1,0).rightSpaceToView(self.rightView,5).heightIs(30);
    btn2.tag = 1001;
    [btn2 setImage:[UIImage imageNamed:@"navigationbar_more"] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] forState:UIControlStateHighlighted];
    [btn2 setTitle:@"雷达" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     btn2.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 48);
    btn2.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);

    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightView addSubview:btn3];
    btn3.sd_layout.rightSpaceToView(self.rightView,5).topSpaceToView(btn2,0).rightSpaceToView(self.rightView,5).heightIs(30);
    btn3.tag = 1002;
    [btn3 setImage:[UIImage imageNamed:@"navigationbar_more"] forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] forState:UIControlStateHighlighted];
    [btn3 setTitle:@"打车" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     btn3.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 45);
     btn3.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);

    
    
}

#pragma mark - HWDropdownMenuDelegate
/**
 *  下拉菜单被销毁了
 */
- (void)dropdownMenuDidDismiss:(DropdownMenu *)menu
{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    // 让箭头向下
    titleButton.selected = NO;
}

/**
 *  下拉菜单显示了
 */
- (void)dropdownMenuDidShow:(DropdownMenu *)menu
{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    // 让箭头向上
    titleButton.selected = YES;
}
//点击tableview消失
- (void)dropdownMenuDidDeDismiss:(DropdownMenu *)menu titleLabel:(NSString *)titleLabel {
    if ([titleLabel isEqualToString:@"全部"]) {
        titleLabel = @"@泡沫";
    }
    [self setUpNavigationTitle:titleLabel];
}

- (void)requestDateMain {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
     AccountModel *model = [AccountTool account];
    [dic setObject:model.access_token forKey:@"access_token"];
    [dic setObject:@"20" forKey:@"count"];
    [dic setObject:[NSString stringWithFormat:@"%ld",self.currentPage] forKey:@"page"];
    [dic setObject:@"0" forKey:@"base_app"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [JHHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" params:dic success:^(id responseObj) {
       
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSArray *statusesArr = [responseObj objectForKey:@"statuses"];
        if (ishead) {
             [self.tableview.mj_footer endRefreshing];
        } else {
             self.tabBarItem.badgeValue = nil;
            [self.tableview.mj_header endRefreshing];
            [self.dateArr removeAllObjects];
        }

        NSMutableArray *newCount = [NSMutableArray array];
        for (NSDictionary *temp in statusesArr) {
            StatusesModel *model = [StatusesModel mj_objectWithKeyValues:temp];
            [self.dateArr addObject:model];
            if ([self.idArr containsObject:model.id]) {
                
            } else {
                [newCount addObject:model.id];
            }
            [self.idArr addObject:model.id];
        }
         [self showNewCount:newCount.count];
         [self.tableview reloadData];
       
    } failure:^(NSError *error) {
         [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
- (void)setUpUnreadCount {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    AccountModel *model = [AccountTool account];
    [dic setObject:model.uid forKey:@"uid"];
    [dic setObject:model.access_token forKey:@"access_token"];
    [JHHttpTool GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" params:dic success:^(id responseObj) {
       
       int status = [[responseObj objectForKey:@"status"] intValue];
        if (status == 0) {
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        } else {
             self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",status];
             [UIApplication sharedApplication].applicationIconBadgeNumber = status;
        }
       
    } failure:^(NSError *error) {
        
    }];
}
#pragma UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dateArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   StatusesModel *model = [self.dateArr objectAtIndex:indexPath.row];
    if (model.pic_urls.count == 0) {
        HomeStatesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.model = model;
        cell.backgroundColor = [UIColor clearColor];
        [cell.rightButton addTarget:self action:@selector(handleSelectRight:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    } else {
        HomeStatuesPictureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"picture" forIndexPath:indexPath];
        cell.model = model;
        cell.backgroundColor = [UIColor clearColor];
        [cell.rightButton addTarget:self action:@selector(handleSelectRight:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     StatusesModel *model = [self.dateArr objectAtIndex:indexPath.row];
    int rows = 0;
    if (model.pic_urls.count % 3 == 0) {
        rows = (int )model.pic_urls.count / 3;
    } else {
        rows = (int )model.pic_urls.count / 3 + 1;
    }
    if (model.pic_urls.count > 0) {
//        原声微博而且有图片
       
         return 110 + [self.view hightForContent:model.text textWidth:WIDTH - 50 textHight:HIGHT textFont:15].size.height + 30 + rows * (pictureWidth + pictureMargin );
    } else {
        if (model.retweeted_status == nil) {
//            没有转发微博而且没有图片
             return 110 + [self.view hightForContent:model.text textWidth:WIDTH - 50 textHight:HIGHT textFont:15].size.height + 31;
        } else {
//            转发微博
             NSString *otherString = [NSString stringWithFormat:@"@%@:%@",model.retweeted_status.user.name,model.retweeted_status.text];
           CGFloat textHeight = [self.view hightForContent:otherString textWidth:WIDTH - 40 textHight:CGFLOAT_MAX textFont:15].size.height;
            
            CGFloat pictureheight;
            int statues = 0;
            if (model.retweeted_status.pic_urls.count % 3 == 0) {
                statues = (int )model.retweeted_status.pic_urls.count / 3;
            } else {
                statues = (int )model.retweeted_status.pic_urls.count / 3 + 1;
            }
           pictureheight = statues * (pictureWidth + pictureMargin);
//            if (model.retweeted_status.pic_urls.count == 0) {
//                pictureheight = 0;
//            } else {
//                pictureheight = rows * (pictureWidth + pictureMargin);
//            }
             return 110 + [self.view hightForContent:model.text textWidth:WIDTH - 50 textHight:HIGHT textFont:15].size.height + 31 + textHeight + 10 + pictureheight;
        }
      
    }
    
   
}
- (void)handleSelectRight:(UIButton *)sender {
   HomeStatesTableViewCell *cell = (HomeStatesTableViewCell *) [[[[sender superview] superview] superview] superview];
   NSIndexPath *indexPath = [self.tableview indexPathForCell:cell];
      StatusesModel *model = [self.dateArr objectAtIndex:indexPath.row];
   
    [SRActionSheet sr_showActionSheetViewWithTitle:nil
                                 cancelButtonTitle:@"取消"
                            destructiveButtonTitle:nil
                                 otherButtonTitles:@[@"收藏", @"帮上头条", @"取消关注",@"屏蔽",@"举报"]
                                  selectSheetBlock:^(SRActionSheet *actionSheetView, NSInteger actionIndex) {
                                      NSLog(@"%zd", actionIndex);
                                  }];
 
}
- (void)showNewCount:(NSInteger )count {
    UILabel *label  = [[UILabel alloc]init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = WIDTH;
    label.height = 35;
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.y = 64 - label.height;
    if (count == 0) {
        label.text = @"没有最新的微博数据，稍后再试";
    } else {
        label.text = [NSString stringWithFormat:@"共有%ld条新的微博数据",count];
    }
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    //动画出来
//    UIViewAnimationOptionCurveEaseInOut            = 0 << 16, // default
//    UIViewAnimationOptionCurveEaseIn               = 1 << 16,
//    UIViewAnimationOptionCurveEaseOut              = 2 << 16,
//    UIViewAnimationOptionCurveLinear 匀速
    CGFloat duration = 1.0;
    [UIView animateWithDuration:duration animations:^{
        label.y += label.height;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration delay:1 options:UIViewAnimationOptionCurveLinear animations:^{
            label.y -= label.height;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}
@end
