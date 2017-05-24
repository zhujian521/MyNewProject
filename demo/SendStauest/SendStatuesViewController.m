//
//  SendStatuesViewController.m
//  demo
//
//  Created by lanou3g on 16/12/7.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import "SendStatuesViewController.h"
#import "AccountTool.h"
#import "AccountModel.h"
#import "PlaceTextView.h"
#import "JHHttpTool.h"
#import "ComposeToolbar.h"
#import "EmotionKeyboard.h"
#import "EmotionModel.h"
@interface SendStatuesViewController ()<UITextViewDelegate,ComposeToolbarDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic ,strong)PlaceTextView *PlacetextView;
@property (nonatomic ,strong)UIBarButtonItem *rightBar;
@property (nonatomic ,strong)ComposeToolbar *tempToolbar;
@property (nonatomic ,strong)EmotionKeyboard *keyboard;
@property (nonatomic ,assign)BOOL swichkeyboard;

@end

@implementation SendStatuesViewController
-  (EmotionKeyboard *)keyboard {
    if (_keyboard == nil) {
        self.keyboard = [[EmotionKeyboard alloc]init];
        
    }
    return _keyboard;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpNavigationBar];
    [self setUpTextView];
    [self setUpToolbar];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getEmotion:) name:@"ClikeEmotion" object:nil];
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.PlacetextView becomeFirstResponder];
}
- (void)getEmotion:(NSNotification *)notification {
   EmotionModel *model = notification.userInfo[@"key"];
    NSLog(@"==%@ %@ ",[model.code emoji],model.png);
    [self.PlacetextView insertEmotion:model];


}
- (void)setUpToolbar {
    ComposeToolbar *toolbar = [[ComposeToolbar alloc]init];
    toolbar.delegate = self;
    toolbar.width = WIDTH;
    toolbar.height = 44;
    toolbar.y = HIGHT - 44;
    [self.view addSubview:toolbar];
    self.tempToolbar = toolbar;
//    self.PlacetextView.inputAccessoryView = toolbar;放到键盘上和键盘同事出现和想隐藏
}
- (void)setUpNavigationBar {
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancle)];
    self.navigationItem.leftBarButtonItem = leftBar;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    dic[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [leftBar setTitleTextAttributes:dic forState:UIControlStateNormal];
    
   self.rightBar = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendMessage)];
    self.navigationItem.rightBarButtonItem = self.rightBar;
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    dic1[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    dic1[NSForegroundColorAttributeName] = [UIColor grayColor];
    [self.rightBar setTitleTextAttributes:dic1 forState:UIControlStateNormal];
   
    self.rightBar.enabled = NO;
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.width = 200;
    titleLabel.height = 44;
    titleLabel.textAlignment = NSTextAlignmentCenter;
   titleLabel.numberOfLines = 0;
    NSString *name = @"delegateAndBlock";
    NSString *prefix = @"发微博";
    NSString *str = [NSString stringWithFormat:@"%@\n%@",prefix,name];
  
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:str];
    [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:[str rangeOfString:prefix]];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[str rangeOfString:name]];
     [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:[str rangeOfString:name]];
    
    NSTextAttachment *attach = [[NSTextAttachment alloc]init];
    attach.image = [UIImage imageNamed:@"avatar_vgirl"];
    attach.bounds = CGRectMake(0, 0, 15, 15);
    NSAttributedString *AttributedString = [NSAttributedString attributedStringWithAttachment:attach];
    [text appendAttributedString:AttributedString];
   
    
       titleLabel.attributedText = text;
    self.navigationItem.titleView = titleLabel;
    
}
- (void)cancle {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)sendMessage {
   //https://api.weibo.com/2/statuses/update.json
    NSString *url = @"https://api.weibo.com/2/statuses/update.json";
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.PlacetextView.text forKey:@"status"];
    AccountModel *model = [AccountTool account];
    [dic setObject:model.access_token forKey:@"access_token"];
    
    [JHHttpTool POST:url params:dic success:^(id responseObj) {
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } failure:^(NSError *error) {
        
    }];
}
- (void)setUpTextView {
    PlaceTextView *textView = [[PlaceTextView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HIGHT)];
    textView.placeholder = @"分享是师傅";
    textView.placeholderColor = [UIColor redColor];
    textView.font = [UIFont systemFontOfSize:15];
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    self.PlacetextView = textView;
    [NotificationCenter addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:textView];
    
    [NotificationCenter addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [self.view addSubview:textView];
//    键盘的frame发生改变发出的通知
//    UIKeyboardWillChangeFrameNotification
//     UIKeyboardDidChangeFrameNotification
//   键盘显示发出的通知
//    UIKeyboardWillShowNotification;
//   UIKeyboardDidShowNotification;
//    键盘隐藏的时候发出的通知
//   UIKeyboardWillHideNotification;
//   UIKeyboardDidHideNotification;
   
}
- (void)keyboardChange:(NSNotification *)notification {
//    {
//        UIKeyboardAnimationCurveUserInfoKey = 7;
//        UIKeyboardAnimationDurationUserInfoKey = "0.25";弹出的时间
//        UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 465}, {414, 271}}";
//        UIKeyboardIsLocalUserInfoKey = 1;
//    }
    if (self.swichkeyboard) return;
    NSDictionary *userInfo = notification.userInfo;
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboard = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:duration animations:^{
        self.tempToolbar.y = keyboard.origin.y - self.tempToolbar.height;
    }];
}
- (void)textChange {
    self.rightBar.enabled = self.PlacetextView.hasText;
   
    if (self.PlacetextView.hasText) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[NSFontAttributeName] = [UIFont systemFontOfSize:15];
        dic[NSForegroundColorAttributeName] = [UIColor orangeColor];
         [self.rightBar setTitleTextAttributes:dic forState:UIControlStateNormal];
        
    } else {
        NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
        dic1[NSFontAttributeName] = [UIFont systemFontOfSize:15];
        dic1[NSForegroundColorAttributeName] = [UIColor grayColor];
        [self.rightBar setTitleTextAttributes:dic1 forState:UIControlStateNormal];

    }
}
#pragma UITextViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}
#pragma ComposeToolbarDelegate
- (void)handleTool:(ComposeToolbar *)toolBar button:(ComposeToolbarType)index {
    switch (index) {
        case ComposeToolbarCamera:
             NSLog(@"ComposeToolbarCamera");
            [self selectImage];
            break;
        case ComposeToolbarPicture:
            NSLog(@"ComposeToolbarPicture");
            break;
        case ComposeToolbarAt:
             NSLog(@"ComposeToolbarAt");
            break;
        case ComposeToolbarTrend:
             NSLog(@"ComposeToolbarTrend");
            break;
        case ComposeToolbarEmotion:
            [self switchKeboard];
            break;
        default:
            break;
    }
}
- (void)switchKeboard {
    if (self.PlacetextView.inputView == nil) {
        self.keyboard.width = WIDTH;
         self.keyboard.height = 216;
        self.PlacetextView.inputView =  self.keyboard;
        self.tempToolbar.showKeyBoard = YES;
        
    } else {
        self.PlacetextView.inputView = nil;
        self.tempToolbar.showKeyBoard = NO;
    }
    self.swichkeyboard = YES;
    [self.view endEditing:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.swichkeyboard = NO;
        [self.PlacetextView becomeFirstResponder];
       
    });
    
    
}
- (void)selectImage{
    
    //调用系统相册的类
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
    
    
    //设置选取的照片是否可编辑
    pickerController.allowsEditing = YES;
    //设置相册呈现的样式
    pickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;//图片分组列表样式
    //照片的选取样式还有以下两种
    //UIImagePickerControllerSourceTypePhotoLibrary,直接全部呈现系统相册
    //UIImagePickerControllerSourceTypeCamera//调取摄像头
    
    //选择完成图片或者点击取消按钮都是通过代理来操作我们所需要的逻辑过程
    pickerController.delegate = self;
    //使用模态呈现相册
    [self.navigationController presentViewController:pickerController animated:YES completion:^{
        
    }];
    
}
//点击取消按钮所执行的方法

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    
    //这是捕获点击右上角cancel按钮所触发的事件，如果我们需要在点击cancel按钮的时候做一些其他逻辑操作。就需要实现该代理方法，如果不做任何逻辑操作，就可以不实现
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    //info是所选择照片的信息
    
    //    UIImagePickerControllerEditedImage//编辑过的图片
    //    UIImagePickerControllerOriginalImage//原图
    
    
    NSLog(@"%@",info);
    
    UIImage *resultImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    //使用模态返回到软件界面
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)dealloc {
    [NotificationCenter removeObserver:self];
}

@end
