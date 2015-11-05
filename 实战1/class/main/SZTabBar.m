//
//  SZTabBar.m
//  实战1
//
//  Created by apple on 15/10/29.
//  Copyright © 2015年 apple. All rights reserved.
//
#import "SZTabBar.h"
#import "SZTabBarButton.h"

@interface SZTabBar()
@property (nonatomic, weak) UIButton *plusButton;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, weak ) UIButton *selectedButton;
@end
@implementation SZTabBar

-(NSMutableArray *)buttons{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
    
}
-(void)setItems:(NSArray *)items
{
    
    _items = items;

    //遍历模型数组
    for (UITabBarItem *item in _items) {
        SZTabBarButton *btn = [SZTabBarButton buttonWithType:UIButtonTypeCustom];
        
        btn.item = item;
        
        btn.tag = self.buttons.count;
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        if (btn.tag == 0) {// 默认选中第0个
            [self btnClick:btn];
        }
        [self addSubview:btn];

        [self.buttons addObject:btn];
    }
    
    

}

-(void)btnClick:(UIButton *)button{
    
    _selectedButton.selected = NO;
    button.selected = YES;
    _selectedButton = button;
    
    if ([_delegate respondsToSelector:@selector(tabBar:didClickButton:)]) {
        
        [_delegate tabBar:self didClickButton:button.tag];
        
    }
   
}

-(UIButton *)plusButton{
    if (_plusButton==nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        // 默认按钮的尺寸跟背景图片一样大
        // sizeToFit:默认会根据按钮的背景图片或者image和文字计算出按钮的最合适的尺寸
        
        [btn sizeToFit];
        _plusButton = btn;
        
        [self addSubview:_plusButton];
    }
    
    return _plusButton;
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];

    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnw = w/(self.items.count + 1);
    CGFloat btnH = h;

    int i=0;
    for (UIView *tabBarButton in self.subviews) {
        
//        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"SZTabBarButton")]) {//SZTabBarButton
            
            if (i==2) {
                i=3;
            }
            btnX = i* btnw;
            
            tabBarButton.frame = CGRectMake(btnX, btnY, btnw, btnH);
            i++;
        }
      
    }
    // 设置添加按钮的位置
    self.plusButton.center = CGPointMake(w * 0.5, h * 0.5);
   
}



@end
