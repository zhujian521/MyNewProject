//
//  TwoHomeViewController.m
//  demo
//
//  Created by 北京启智 on 2016/11/21.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import "TwoHomeViewController.h"
#import "DroprightMenu.h"
#import "PopButtonView.h"
#import "ShoppingVC.h"
#import "StepVC.h"
@interface TwoHomeViewController ()
@property (nonatomic ,strong)UIView *rightView;
@end

@implementation TwoHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // style : 这个参数是用来设置背景的，在iOS7之前效果比较明显, iOS7中没有任何效果
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发现群" style:UIBarButtonItemStylePlain target:self action:@selector(composeMsg)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor grayColor]}];
     self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(handleRightAction:) image:@"timeline_icon_comment" highImage:@"timeline_icon_comment"];
    
    
    UIButton *popButton = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH - 60, HIGHT - 300, 50, 50)];
    [self.view addSubview:popButton];
    [popButton setImage:[UIImage imageNamed:@"tabbar_compose_more"] forState:UIControlStateNormal];
    [popButton addTarget:self action:@selector(handleClike:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)handleClike:(UIButton *)sender {
    //遮挡层
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    CGRect newFrame = [sender convertRect:sender.bounds toView:keyWindow];
    CGFloat y = CGRectGetMidY(newFrame);
    CGFloat x = CGRectGetMinX(newFrame);

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
    
    PopButtonView *popview = [[PopButtonView alloc]initWithFrame:CGRectMake(0,  y - 110, WIDTH , 220)];
    popview.backgroundColor = [UIColor clearColor];
    [downView addSubview:popview];
    popview.tag = 1004;
    
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

- (void)composeMsg {
    ShoppingVC *shopVC = [[ShoppingVC alloc]init];
    [self.navigationController pushViewController:shopVC animated:YES];
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
    [menu showFrom:sender];
    menu.rightBlock = ^(UIButton *sender) {
        StepVC *vc = [[StepVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    };

}
- (void)setUpRightButton {
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightView addSubview:btn1];
    btn1.sd_layout.rightSpaceToView(self.rightView,5).topSpaceToView(self.rightView,5).rightSpaceToView(self.rightView,5).heightIs((self.rightView.height-10) / 2);
    
    [btn1 setImage:[UIImage imageNamed:@"timeline_icon_comment"] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"timeline_icon_comment"] forState:UIControlStateHighlighted];
    [btn1 setTitle:@"发起聊天" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn1.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    btn1.tag = 1000;
    
    
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightView addSubview:btn2];
    btn2.sd_layout.rightSpaceToView(self.rightView,5).topSpaceToView(btn1,0).rightSpaceToView(self.rightView,5).heightIs((self.rightView.height-10) / 2);
    btn2.tag = 1001;
    [btn2 setImage:[UIImage imageNamed:@"timeline_icon_comment"] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"timeline_icon_comment"] forState:UIControlStateHighlighted];
    [btn2 setTitle:@"私密聊天" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn2.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
  
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
