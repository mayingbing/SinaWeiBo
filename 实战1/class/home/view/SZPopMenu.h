//
//  SZPopMenu.h
//  实战1
//
//  Created by apple on 15/10/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZPopMenu : UIImageView

/**
 *  显示弹出菜单
 */
+(instancetype)showInRect:(CGRect)rect;

/**
 *  隐藏弹出菜单
 */
+ (void)hide;

@property(nonatomic, weak) UIView *contentView;


@end
