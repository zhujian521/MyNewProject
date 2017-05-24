//
//  RegisterViewController.m
//  demo
//
//  Created by 北京启智 on 2016/11/16.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(242, 242, 242);
    self.title = @"注册";
    [self setUpView];
    
   
}

- (void)setUpView {
    UIImageView *logoimage = [[UIImageView alloc]init];
    [self.view addSubview:logoimage];
    logoimage.sd_layout.topSpaceToView(self.view,100).widthIs(44).heightIs(44).centerXEqualToView(self.view);
    logoimage.layer.masksToBounds = YES;
    logoimage.layer.cornerRadius = 22;
    logoimage.backgroundColor = [UIColor blueColor];
    
    UILabel *phoneLabel = [[UILabel alloc]init];
    [self.view addSubview:phoneLabel];
    phoneLabel.text = @"手机号:";
    phoneLabel.sd_layout.leftSpaceToView(self.view,20).topSpaceToView(logoimage,30).widthIs(70).heightIs(30);
    
    self.phoneField = [[UITextField alloc]init];
    [self.view addSubview:self.phoneField];
    self.phoneField.sd_layout.leftSpaceToView(phoneLabel,10).rightSpaceToView(self.view,30).heightIs(30).centerYEqualToView(phoneLabel);
    self.phoneField.placeholder = @"请输入手机号";
    self.phoneField.backgroundColor = [UIColor whiteColor];
    self.phoneField.layer.masksToBounds = YES;
    self.phoneField.layer.cornerRadius = 3;
    
    UILabel *codeLabel = [[UILabel alloc]init];
    [self.view addSubview:codeLabel];
    codeLabel.text = @"验证码:";
    codeLabel.sd_layout.leftSpaceToView(self.view,20).topSpaceToView(phoneLabel,15).widthIs(70).heightIs(30);
    
    self.codeField = [[UITextField alloc]init];
    [self.view addSubview:self.codeField];
    self.codeField.sd_layout.leftSpaceToView(codeLabel,10).rightSpaceToView(self.view,120).heightIs(30).centerYEqualToView(codeLabel);
    self.codeField.placeholder = @"请输入短信验证码";
    self.codeField.backgroundColor = [UIColor whiteColor];
    self.codeField.layer.masksToBounds = YES;
    self.codeField.layer.cornerRadius = 3;
    
    UIButton *sendCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:sendCodeButton];
    sendCodeButton.sd_layout.leftSpaceToView(self.codeField,10).rightSpaceToView(self.view,30).heightIs(30).centerYEqualToView(self.codeField);
    sendCodeButton.backgroundColor = [UIColor redColor];
    [sendCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    sendCodeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    sendCodeButton.layer.masksToBounds = YES;
    sendCodeButton.layer.cornerRadius = 8;
    [sendCodeButton addTarget:self action:@selector(handleActionReciver:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)handleActionReciver:(UIButton *)sender {
    __block int timeout= 60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                
                [sender setTitle:@"获取验证码" forState:UIControlStateNormal];
                
                sender.userInteractionEnabled = YES;
                
            });
            
        }else{
            
            //            int minutes = timeout / 60;
            
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                
                [UIView beginAnimations:nil context:nil];
                
                [UIView setAnimationDuration:1];
                
                [sender setTitle:[NSString stringWithFormat:@"%@秒重发",strTime] forState:UIControlStateNormal];
                
                [UIView commitAnimations];
                
                sender.userInteractionEnabled = NO;
                
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);

}

@end
