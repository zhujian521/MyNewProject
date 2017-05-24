//
//  ViewController.m
//  demo
//
//  Created by 北京启智 on 2016/11/15.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import "ViewController.h"
#import "JHHttpTool.h"
#import "MainViewController.h"
#import "MJExtension.h"
#import "AccountModel.h"
#import "MBProgressHUD.h"
#import "AccountTool.h"
@interface ViewController ()<UIWebViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpWebview];
    
}

- (void)setUpWebview {
    UIWebView *webview = [[UIWebView alloc]initWithFrame:self.view.frame];
    webview.delegate = self;
    [self.view addSubview:webview];
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=1913034200&redirect_uri=https://www.baidu.com"];
    [webview loadRequest:[NSURLRequest requestWithURL:url]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *url = request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) {
        int fromIndex = range.location + range.length;
        NSString *code = [url substringFromIndex:fromIndex];
               [self requestToken:code];
        //禁止加载回调地址
        return NO;
    }
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (void)requestToken:(NSString *)code {
    NSString *url = @"https://api.weibo.com/oauth2/access_token";
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"1913034200" forKey:@"client_id"];
    [dic setObject:@"authorization_code" forKey:@"grant_type"];
    [dic setObject:code forKey:@"code"];
    [dic setObject:@"https://www.baidu.com" forKey:@"redirect_uri"];
    [dic setObject:@"acd9a0f3a6afa87fe059538a5688f5eb" forKey:@"client_secret"];
    
    [JHHttpTool POST:url params:dic success:^(id responseObj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
       NSString *access_token = [responseObj objectForKey:@"access_token"];
       NSString *uid = [responseObj objectForKey:@"uid"];
       NSString *expires_in = [responseObj objectForKey:@"expires_in"];
      NSUserDefaults *userDefaults =  [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:access_token forKey:@"token"];
        [userDefaults setObject:uid forKey:@"uid"];
        [userDefaults setObject:expires_in forKey:@"expires_in"];
        [userDefaults synchronize];
        
        NSDictionary *dic = (NSDictionary *)responseObj;
        AccountModel *model = [AccountModel mj_objectWithKeyValues:dic];
        [AccountTool saveAcount:model];//存储用户的帐号信息
        
        [self loadMainVC];
    } failure:^(NSError *error) {
           [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)loadMainVC {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    MainViewController *mainVC = [[MainViewController alloc]init];
    window.rootViewController = mainVC;
}


@end
