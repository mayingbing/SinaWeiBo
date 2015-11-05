//
//  SZRootTool.m
//  实战1
//
//  Created by apple on 15/11/4.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SZRootTool.h"
#import "SZTabBarController.h"
#import "SZNewFeatureController.h"

@implementation SZRootTool

+ (void)chooseRootViewController:(UIWindow *)window{
    
    //// 1.获取当前的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    // 2.获取上一次的版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"version"];
    
    // v1.0
    // 判断当前是否有新的版本
    if ([currentVersion isEqualToString:lastVersion])
    {
        // 没有最新的版本号
        // 创建tabBarVc
        SZTabBarController *tabBarVc = [[SZTabBarController alloc] init];
        
        // 设置窗口的根控制器
        window.rootViewController = tabBarVc;
        
    }
    else{
        // 有最新的版本号
        
        // 进入新特性界面
        // 如果有新特性，进入新特性界面
        SZNewFeatureController *nvc = [[SZNewFeatureController alloc] init];
        
        window.rootViewController = nvc;
        
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"version"];
    }
    

    
}

@end
