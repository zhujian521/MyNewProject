//
//  MainViewController.m
//  demo
//
//  Created by 北京启智 on 2016/11/21.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "TwoHomeViewController.h"
#import "ShopViewController.h"
#import "MineViewController.h"
#import "LoginViewController.h"
#import "MainNavigationController.h"
#import "MainNavigationViewController.h"
#import "AppDelegate.h"
#import "CustomTabBar.h"
#import "SendStatuesViewController.h"
#import "LoginViewController.h"
#import "SelectPictureVC.h"
#import "FMImagePicker.h"
#import "VideoVC.h"
#define TextColor [UIColor colorWithRed:155 / 255.0 green:210 / 255.0 blue:105 / 255.0 alpha:1.0]
@interface MainViewController ()<UITabBarControllerDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    HomeViewController  * HomeVC = [[HomeViewController alloc]init];
    [self addChildVc:HomeVC Title:@"首页" withTitleSize:12.0 andFoneName:@"HelveticaNeue-Bold" selectedImage:@"tabbar_home_selected" withTitleColor:[UIColor orangeColor] unselectedImage:@"tabbar_home" withTitleColor:[UIColor lightGrayColor]];
    TwoHomeViewController  *TwoHomeVC = [[TwoHomeViewController alloc]init];
    [self addChildVc:TwoHomeVC Title:@"周边" withTitleSize:12.0 andFoneName:@"HelveticaNeue-Bold" selectedImage:@"tabbar_message_center_selected" withTitleColor:[UIColor orangeColor] unselectedImage:@"tabbar_message_center" withTitleColor:[UIColor lightGrayColor]];
     
    ShopViewController  *ShopVC = [[ShopViewController alloc]init];
    [self addChildVc:ShopVC Title:@"购物车" withTitleSize:12.0 andFoneName:@"HelveticaNeue-Bold" selectedImage:@"tabbar_discover_selected" withTitleColor:[UIColor orangeColor] unselectedImage:@"tabbar_discover" withTitleColor:[UIColor lightGrayColor]];
    MineViewController  *MineVC = [[MineViewController alloc]init];
    [self addChildVc:MineVC Title:@"我的" withTitleSize:12.0 andFoneName:@"HelveticaNeue-Bold" selectedImage:@"tabbar_profile_selected" withTitleColor:[UIColor orangeColor] unselectedImage:@"tabbar_profile" withTitleColor:[UIColor lightGrayColor]];
   
    // 2.更换系统自带的tabbar
    CustomTabBar *tabBar = [[CustomTabBar alloc] init];
    __weak typeof(self)weakself = self;
    tabBar.addBlock = ^(UIButton *btn){
        [weakself pushAddMessageVC];
    };
    [self setValue:tabBar forKeyPath:@"tabBar"];
    /*
     [self setValue:tabBar forKeyPath:@"tabBar"];相当于self.tabBar = tabBar;
     [self setValue:tabBar forKeyPath:@"tabBar"];这行代码过后，tabBar的delegate就是HWTabBarViewController
     说明，不用再设置tabBar.delegate = self;
     */
    
    /*
     1.如果tabBar设置完delegate后，再执行下面代码修改delegate，就会报错
     tabBar.delegate = self;
     
     2.如果再次修改tabBar的delegate属性，就会报下面的错误
     错误信息：Changing the delegate of a tab bar managed by a tab bar controller is not allowed.
     错误意思：不允许修改TabBar的delegate属性(这个TabBar是被TabBarViewController所管理的)
     */

   
}
- (void)addChildVc:(UIViewController *)childVc
             Title:(NSString *)title
     withTitleSize:(CGFloat)size
       andFoneName:(NSString *)foneName
     selectedImage:(NSString *)selectedImage
    withTitleColor:(UIColor *)selectColor
   unselectedImage:(NSString *)unselectedImage
    withTitleColor:(UIColor *)unselectColor {
    childVc.title = title;
    //设置图片
    childVc.tabBarItem  = [childVc.tabBarItem initWithTitle:title image:[[UIImage imageNamed:unselectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    //未选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:unselectColor,NSFontAttributeName:[UIFont fontWithName:foneName size:size]} forState:UIControlStateNormal];
    
    //选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:selectColor,NSFontAttributeName:[UIFont fontWithName:foneName size:size]} forState:UIControlStateSelected];
    MainNavigationController *nav = [[MainNavigationController alloc] initWithRootViewController:childVc];
       // 添加为子控制器
    [self addChildViewController:nav];
}
#pragma UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    
    // 用户未登录时, 点击 个人中心 push登录界面
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navi = (UINavigationController *)viewController;
        UIViewController *top = (UIViewController *)navi.topViewController;
        UINavigationController *selectNavi = (UINavigationController *)self.selectedViewController;
        UIViewController *selectVC = (UIViewController *)selectNavi.topViewController;
        if ([top isKindOfClass:[MineViewController class]]) {
            LoginViewController *login = [[LoginViewController alloc]init];
            [selectNavi pushViewController:login animated:YES];
            return NO;
        }
    }
    return YES;
}


//点击加号后的跳转
- (void)pushAddMessageVC {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
  
    
    UIView * downView = [[UIView alloc]init];
    downView.frame = CGRectMake(0, 0, WIDTH, HIGHT);
    [keyWindow addSubview:downView];
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH , HIGHT )];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.3;
    [keyWindow addSubview:bgView];
    [keyWindow bringSubviewToFront:downView];
    self.downView = downView;
    self.bgView = bgView;
    
    UIView *popView = [[UIView alloc]initWithFrame:CGRectMake(0, HIGHT / 4 * 2, WIDTH, HIGHT / 4)];
    popView.backgroundColor = [UIColor whiteColor];
    popView.tag = 1002;
    [downView addSubview:popView];
    
    UIButton *MessageButton = [[UIButton alloc]init];
    [popView addSubview:MessageButton];
    MessageButton.tag = 100;
    MessageButton.sd_layout.centerXEqualToView(popView).centerYEqualToView(popView).widthIs(50).heightIs(50);
    [MessageButton setImage:[UIImage imageNamed:@"tabbar_compose_idea"] forState:UIControlStateNormal];
    [MessageButton addTarget:self action:@selector(handleClike:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *PictureButton = [[UIButton alloc]init];
    [popView addSubview:PictureButton];
    PictureButton.tag = 101;
    PictureButton.sd_layout.centerYEqualToView(popView).leftSpaceToView(MessageButton,30).widthIs(50).heightIs(50);
    [PictureButton setImage:[UIImage imageNamed:@"tabbar_compose_photo"] forState:UIControlStateNormal];
    [PictureButton addTarget:self action:@selector(handleClike:) forControlEvents:UIControlEventTouchUpInside];

    
    UIButton *videoButton = [[UIButton alloc]init];
    [popView addSubview:videoButton];
    videoButton.sd_layout.centerYEqualToView(popView).rightSpaceToView(MessageButton,30).widthIs(50).heightIs(50);
    [videoButton setImage:[UIImage imageNamed:@"tabbar_compose_review"] forState:UIControlStateNormal];
    videoButton.tag = 102;
    [videoButton addTarget:self action:@selector(handleClike:) forControlEvents:UIControlEventTouchUpInside];


    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleRemoveView:)];
    [downView addGestureRecognizer:tap];

    
}
- (void)handleRemoveView:(UITapGestureRecognizer *)sender {
    UIView *boldView = (UIView *)[self.downView viewWithTag:1002];
    if (CGRectContainsPoint(boldView.frame, [sender locationInView:self.downView])) {
        
    }else{
        [self.bgView removeFromSuperview];
        [self.downView removeFromSuperview];
        self.bgView = nil;
        self.downView = nil;
    }
}

- (void)handleClike:(UIButton *)sender {
    [self.bgView removeFromSuperview];
    [self.downView removeFromSuperview];
    self.bgView = nil;
    self.downView = nil;

    if (sender.tag == 100) {
            UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:[SendStatuesViewController new]];
            [self presentViewController:navi animated:YES completion:nil];

        
    } else if (sender.tag == 101) {
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:[[SelectPictureVC alloc]init]];
        [self presentViewController:navi animated:YES completion:nil];
        
    } else {
        FMImagePicker *picker = [[FMImagePicker alloc] init];
        __weak typeof(self)weakSelf = self;
        picker.videoBlock = ^(NSURL *tempUrl){
//            NSLog(@"相机的文件%@",tempUrl);
            VideoVC *video = [[VideoVC alloc]init];
            video.url = tempUrl;
            UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:video];
            [weakSelf presentViewController:navigation animated:YES completion:nil];
            
        };
        [self presentViewController:picker animated:YES completion:nil];

    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}



@end
