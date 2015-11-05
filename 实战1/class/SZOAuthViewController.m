//
//  SZOAuthViewController.m
//  实战1
//
//  Created by apple on 15/11/3.
//  Copyright © 2015年 apple. All rights reserved.
//
#import "SZOAuthViewController.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"

#import "SZAccount.h"
#import "SZAccountTool.h"
#import "SZRootTool.h"

@interface SZOAuthViewController ()<UIWebViewDelegate>

@end

@implementation SZOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 展示登陆的网页 -> UIWebView
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:webView];
    
    // 加载网页https://api.weibo.com/oauth2/access_token
    
    // 一个完整的URL:基本URLhttps://api.weibo.com/oauth2/authorize + 参数
    
    NSString *baseUrl = @"https://api.weibo.com/oauth2/authorize";
    NSString *client_id = @"1489624090";
    NSString *redirect_uri = @"http://www.baidu.com";
    
    // 拼接URL字符串
   
    NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",baseUrl,client_id,redirect_uri];
    
   // NSLog(@"urlStr=%@",urlStr);
    // 创建URL
    NSURL *url = [NSURL URLWithString:urlStr];
    
    
    // 创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 加载请求;
    [webView loadRequest:request];
    
    // 设置代理
    
    webView.delegate = self;
    
    
}
#pragma mark -UIWebView代理

-(void)webViewDidStartLoad:(UIWebView *)webView{
    
     // 提示用户正在加载...
    [MBProgressHUD showMessage:@"正在加载"];
    
}

// webview加载完成的时候调用

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [MBProgressHUD hideHUD];
    
}

//  webview加载失败的时候调用

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [MBProgressHUD hideHUD];
    
}

// 拦截webView请求
// 当Webview需要加载一个请求的时候，就会调用这个方法，询问下是否请求

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *urlStr = request.URL.absoluteString;
    // 获取code(RequestToken)
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.length) {// 有code=

        NSString *code = [urlStr substringFromIndex:range.location + range.length];
        
         // 换取accessToken
        [self accessTokenWithCode:code];
         // 不会去加载回调界面
        return NO;
      
    }
    return YES;
}

-(void)accessTokenWithCode:(NSString *)code{
    
    // 发送Post请求
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"client_id"] = @"1489624090";
    params[@"client_secret"] = @"5b5c8fc04b6666306fbe2c4636414cec";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = @"http://www.baidu.com";
    
       // 发送请求
    
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation,id respondeObject){
        
        // 请求成功的时候调用// 请求成功的时候调用
        
      //  NSLog(@"%@",respondeObject);
        
        // 字典转模型
        
        SZAccount *account = [SZAccount accountWithDict:respondeObject];
        
        // 保存账号信息:
        // 数据存储一般我们开发中会搞一个业务类，专门处理数据的存储
        // 以后我不想归档，用数据库，直接改业务类
        
        [SZAccountTool saveAccount:account];
        
        // 进入主页或者新特性,选择窗口的根控制器
        
        [SZRootTool chooseRootViewController:[UIApplication sharedApplication].keyWindow ];
     
        
    }failure:^(AFHTTPRequestOperation *operation,NSError *error){
        
        // 请求失败的时候调用

     //   NSLog(@"%@",error);
    }];
  
}

@end
