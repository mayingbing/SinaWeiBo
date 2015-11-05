//
//  SZTabBarController.m
//  实战1
//
//  Created by apple on 15/10/29.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SZTabBarController.h"
#import "UIImage+Image.h"
#import "SZTabBar.h"
#import "SZNavigationController.h"

#import "SZHomeViewController.h"
#import "SZMessageViewController.h"
#import "SZDiscoverViewController.h"
#import "SZProfileViewController.h"


@interface SZTabBarController ()<SZTabBarDelegate>

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation SZTabBarController
- (NSMutableArray *)items
{
    if (_items == nil) {
        
        _items = [NSMutableArray array];
        
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAllChildController];
    
    // 自定义tabBar
    [self setUpTabBar];
    
}

#pragma mark - 设置tabBar
- (void)setUpTabBar{
    
    SZTabBar *tabBar = [[SZTabBar alloc] initWithFrame:self.tabBar.frame];
    tabBar.backgroundColor = [UIColor lightGrayColor];
    tabBar.delegate = self;
    
    tabBar.items = self.items;
    

    
    [self.view addSubview:tabBar];
    
    [self.tabBar removeFromSuperview];
    
    
}


-(void)tabBar:(SZTabBar *)tabBar didClickButton:(NSInteger)index{
    
    self.selectedIndex = index;
    
}
- (void)setAllChildController{
    
    //
    SZHomeViewController *home = [[SZHomeViewController alloc] init];
   home.view.backgroundColor = [UIColor blueColor];
  //  home.title = @"首页1111";
    [self setOneChildController:home image:[UIImage imageNamed:@"tabbar_home"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_home_selected"] title:@"首页"];
    
  
    //
    SZMessageViewController *message = [[SZMessageViewController alloc] init];
    message.view.backgroundColor = [UIColor greenColor];
 //   message.title = @"消息";
    message.tabBarItem.title = @"消息";
    [self setOneChildController:message image:[UIImage imageNamed:@"tabbar_message_center"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_message_center_selected"] title:@"消息"];
   
    
    //
    SZDiscoverViewController *discover = [[SZDiscoverViewController alloc] init];
    discover.view.backgroundColor = [UIColor cyanColor];
  //  discover.title = @"发现";
    discover.tabBarItem.title = @"发现";
    [self setOneChildController:discover image:[UIImage imageNamed:@"tabbar_discover"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_discover_selected"] title:@"发现"];
    
    
    
    //
    SZProfileViewController *profile = [[SZProfileViewController alloc] init];
    profile.view.backgroundColor = [UIColor blueColor];
//    profile.title = @"我的";
    [self setOneChildController:profile image:[UIImage imageNamed:@"tabbar_profile"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_profile_selected"] title:@"我的"];
    
}

-(void)setOneChildController:(UIViewController *)vc image:(UIImage *)image  selectedImage:(UIImage *)selectedImage  title:(NSString *)title{
    
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
    vc.tabBarItem.title = title;
    
    // 保存tabBarItem模型到数组
    [self.items addObject:vc.tabBarItem];
    
    // 设置tabBarItem的文字颜色
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [vc.tabBarItem setTitleTextAttributes:titleAttr forState:UIControlStateSelected];
    
    
    //关联navigation
    
    SZNavigationController *nav = [[SZNavigationController alloc]initWithRootViewController:vc];
  //  nav.view.backgroundColor =[UIColor yellowColor];
    
    
    [self addChildViewController:nav];
    
    
}

@end
