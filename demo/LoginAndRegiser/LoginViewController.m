//
//  LoginViewController.m
//  demo
//
//  Created by 北京启智 on 2016/11/15.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "RegisterViewController.h"
#import "UploadImageTool.h"

@interface LoginViewController ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"登录";
    [self setupView];
    [self setupTextFeild];
    //添加文本框通知中心
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gosave:) name:UITextFieldTextDidChangeNotification object:nil];
    
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.loginButton];
    self.loginButton.sd_layout.rightSpaceToView(self.view,40).leftSpaceToView(self.view,40).topSpaceToView(self.passwordField,80).heightIs(40);
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.layer.cornerRadius = 5;
    self.loginButton.backgroundColor = [UIColor lightGrayColor];
    
    CGRect sizelabel = [self.view hightForContent:@"新用户注册" textWidth:WIDTH textHight:30 textFont:15];
    UILabel *newuserLabel = [[UILabel alloc]init];
    [self.view addSubview:newuserLabel];
    newuserLabel.text = @"新用户注册";
    newuserLabel.font = [UIFont systemFontOfSize:15];
    newuserLabel.textColor = [UIColor redColor];
    newuserLabel.sd_layout.topSpaceToView(self.loginButton,5).rightSpaceToView(self.view,40).widthIs(sizelabel.size.width).heightIs(30);
    newuserLabel.userInteractionEnabled = YES;
    
    UIButton *newButton = [[UIButton alloc]init];
    [newuserLabel addSubview:newButton];
    newButton.sd_layout.leftSpaceToView(newuserLabel,0).rightSpaceToView(newuserLabel,0).topSpaceToView(newuserLabel,0).bottomSpaceToView(newuserLabel,0);
    newButton.backgroundColor = [UIColor clearColor];
    [newButton addTarget:self action:@selector(handleNewUser) forControlEvents:UIControlEventTouchUpInside];
    
    [self setupThirdsLogin];
}
- (void)setupView {
    self.logoImage = [[UIImageView alloc]init];
    [self.view addSubview:self.logoImage];
    self.logoImage.sd_layout.centerXEqualToView(self.view).topSpaceToView(self.view,100).widthIs(60).heightIs(60);
    self.logoImage.backgroundColor = [UIColor clearColor];   
    self.logoImage.image = [UIImage imageWithClipeImage:[UIImage imageNamed:@"logo"] border:1 borderColor:[UIColor redColor]];
    
    
}
- (void)setupTextFeild {
    
    UILabel *title1 = [[UILabel alloc]init];
    [self.view addSubview:title1];
    title1.sd_layout.leftSpaceToView(self.view,40).heightIs(30).widthIs(40).topSpaceToView(self.logoImage,60);
    title1.text = @"账号:";
    title1.textAlignment = NSTextAlignmentCenter;
    
    self.phoneField = [[UITextField alloc]init];
    [self.view addSubview:self.phoneField];
    self.phoneField.sd_layout.leftSpaceToView(title1,10).centerYEqualToView(title1).rightSpaceToView(self.view,40).heightIs(30);
    self.phoneField.placeholder = @"请输入手机号";
    self.phoneField.keyboardType = UIKeyboardTypePhonePad;
    self.phoneField.delegate = self;
    self.phoneField.layer.borderWidth = 1;
    self.phoneField.layer.borderColor = [[UIColor redColor] CGColor];
    self.phoneField.textAlignment = NSTextAlignmentCenter;
    
    UILabel *title2 = [[UILabel alloc]init];
    [self.view addSubview:title2];
    title2.sd_layout.leftSpaceToView(self.view,40).heightIs(30).widthIs(40).topSpaceToView(title1,30);
    title2.text = @"密码:";
    title2.textAlignment = NSTextAlignmentCenter;
    
    self.passwordField = [[UITextField alloc]init];
    [self.view addSubview:self.passwordField];
    self.passwordField.sd_layout.leftSpaceToView(title2,10).centerYEqualToView(title2).rightSpaceToView(self.view,40).heightIs(30);
    self.passwordField.placeholder = @"请输入密码";
    self.passwordField.delegate = self;
    self.passwordField.layer.borderWidth = 1;
    self.passwordField.layer.borderColor = [[UIColor redColor] CGColor];
    self.passwordField.textAlignment = NSTextAlignmentCenter;
    
     CGRect rect =  [self.view hightForContent:@"忘记密码?" textWidth:WIDTH textHight:30 textFont:15];
    UILabel *forgetLabel = [[UILabel alloc]init];
    [self.view addSubview:forgetLabel];
    forgetLabel.sd_layout.rightSpaceToView(self.view,40).topSpaceToView(self.passwordField,10).widthIs(rect.size.width).heightIs(30);
    forgetLabel.text = @"忘记密码?";
     forgetLabel.font = [UIFont systemFontOfSize:15];
    forgetLabel.textColor = [UIColor redColor];
    forgetLabel.userInteractionEnabled = YES;
    
    UIButton *forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetLabel addSubview:forgetButton];
    forgetButton.sd_layout.leftSpaceToView(forgetLabel,0).rightSpaceToView(forgetLabel,0).topSpaceToView(forgetLabel,0).bottomSpaceToView(forgetLabel,0);
    forgetButton.backgroundColor = [UIColor clearColor];
    [forgetButton addTarget:self action:@selector(handleForgetCode) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)setupThirdsLogin {
    
    UILabel *thirdsLabel = [[UILabel alloc]init];
    [self.view addSubview:thirdsLabel];
    thirdsLabel.sd_layout.bottomSpaceToView(self.view,HIGHT / 4).centerXEqualToView(self.view).widthIs(WIDTH).heightIs(30);
    thirdsLabel.font = [UIFont systemFontOfSize:15];
    thirdsLabel.text = @"通过第三方账号登录";
    thirdsLabel.textAlignment = NSTextAlignmentCenter;
    thirdsLabel.textColor = [UIColor lightGrayColor];
    
    UIButton *weixinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:weixinButton];
    weixinButton.sd_layout.centerXEqualToView(self.view).topSpaceToView(thirdsLabel,20).widthIs(44).heightIs(44);
    weixinButton.layer.masksToBounds = YES;
    weixinButton.layer.cornerRadius = 22;
    weixinButton.backgroundColor = [UIColor redColor];
    
    UIButton *QQButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:QQButton];
    QQButton.sd_layout.centerYEqualToView(weixinButton).leftSpaceToView(weixinButton,40).widthIs(44).heightIs(44);
    QQButton.layer.masksToBounds = YES;
    QQButton.layer.cornerRadius = 22;
    QQButton.backgroundColor = [UIColor redColor];
    
    UIButton *WeiBoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:WeiBoButton];
    WeiBoButton.sd_layout.centerYEqualToView(weixinButton).rightSpaceToView(weixinButton,40).widthIs(44).heightIs(44);
    WeiBoButton.layer.masksToBounds = YES;
    WeiBoButton.layer.cornerRadius = 22;
    WeiBoButton.backgroundColor = [UIColor redColor];
    
    
}
//通知的响应方法
- (void)gosave:(NSNotification *) Notification {
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.phoneField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}
#pragma UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (void)handleForgetCode {
     __weak typeof(self)weakself = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {}];
    UIAlertAction* fromPhotoAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault                                                                 handler:^(UIAlertAction * action) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imagePicker.allowsEditing = YES;
        imagePicker.delegate = self;//设置代理对象
        //模态推出相册界面
        [self presentViewController:imagePicker animated:YES completion:nil];
        
        
    }];
    UIAlertAction* fromCameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault                                                             handler:^(UIAlertAction * action) {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = weakself;
            imagePicker.allowsEditing = YES;
            // imagePicker.allowsEditing = NO;
            imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePicker animated:YES completion:nil];
        } else {
           NSLog(@"相机不可使用");
        }
    }];
    [alert addAction:cancelAction];
    [alert addAction:fromCameraAction];
    [alert addAction:fromPhotoAction];
    [self presentViewController:alert animated:YES completion:nil];}
- (void)handleNewUser {
    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}
#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo  {
    
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //通过选中的图片得到之后,让空间显示
    self.logoImage.image  = [info objectForKey:UIImagePickerControllerEditedImage];
    [self dismissViewControllerAnimated:YES completion:nil];//模态退出
    
        [UploadImageTool uploadImage:self.logoImage.image progress:^(NSString *key, float percent) {
            
        } success:^(NSString *url) {
            
        } failure:^(NSError *error) {
            
        }];
    
    
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self dismissViewControllerAnimated:YES completion:nil];//模态退出
}
@end
