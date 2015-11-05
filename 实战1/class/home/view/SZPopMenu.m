//
//  SZPopMenu.m
//  实战1
//
//  Created by apple on 15/10/30.
//  Copyright © 2015年 apple. All rights reserved.
//
#import "UIImage+Image.h"
#import "SZPopMenu.h"

@implementation SZPopMenu
// 显示弹出菜单
+(instancetype)showInRect:(CGRect)rect{
    
    SZPopMenu *menu = [[SZPopMenu alloc] initWithFrame:rect];
    menu.userInteractionEnabled = YES;
    menu.image = [UIImage imageWithStretchableName:@"popover_background"];
    
    [[UIApplication sharedApplication].keyWindow addSubview:menu];
    
    return menu;
}


// 隐藏弹出菜单
+ (void)hide{
    
    for (UIView *popMenu in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([popMenu isKindOfClass:self]) {
            [popMenu removeFromSuperview];
        }
    }
    
    
}


-(void)setContentView:(UIView *)contentView{
    // 先移除之前内容视图
    [_contentView removeFromSuperview];
    
    _contentView = contentView;
    
    contentView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:contentView];
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
    // 计算内容视图尺寸
    
    CGFloat y = 9;
    CGFloat margin = 5;
    CGFloat x = margin;
    CGFloat w = self.bounds.size.width - 2 * margin;
    CGFloat h = self.bounds.size.height - y - margin;
    
    _contentView.frame = CGRectMake(x, y, w, h);
    
}







@end
