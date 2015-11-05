//
//  AppDelegate.m
//  实战1
//
//  Created by apple on 15/10/29.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "SZTabBarController.h"
#import "SZNewFeatureController.h"
#import "SZOAuthViewController.h"
#import "SZAccountTool.h"
#import "SZRootTool.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
 
//    SZOAuthViewController *SZOAth = [[SZOAuthViewController alloc] init];
//    
//    self.window.rootViewController = SZOAth;
    
    // 选择根控制器
        // 判断下有没有授权
        if ([SZAccountTool account]) { // 已经授权
    
            // 选择根控制器
            [SZRootTool chooseRootViewController:self.window];
    
        }else{ // 进行授权
            SZOAuthViewController *oauthVc = [[SZOAuthViewController alloc] init];
    
            // 设置窗口的根控制器
            self.window.rootViewController = oauthVc;
    
        }
      // 显示窗口
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
