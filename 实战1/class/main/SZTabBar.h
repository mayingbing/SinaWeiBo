//
//  SZTabBar.h
//  实战1
//
//  Created by apple on 15/10/29.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SZTabBar;
@protocol SZTabBarDelegate <NSObject>

@optional
-(void)tabBar:(SZTabBar *)tabBar didClickButton:(NSInteger)index;

@end

@interface SZTabBar : UIView

// items:保存每一个按钮对应tabBarItem模型

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, weak) id<SZTabBarDelegate> delegate;

@end
