//
//  SZCover.m
//  实战1
//
//  Created by apple on 15/10/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SZCover.h"

@implementation SZCover
// 设置浅灰色蒙板
//-(void)setDimBackground:(BOOL)dimBackground{
//    
//    _dimBackground = dimBackground;
//    
//    if (dimBackground) {
//        
//        self.backgroundColor = [UIColor grayColor];
//        self.alpha = 0.5;
//    }
//    else{
//        self.alpha = 1;
//        self.backgroundColor = [UIColor clearColor];
//    }
//    
//}

+(instancetype)show{
    
    SZCover *cover = [[SZCover alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    cover.backgroundColor = [UIColor clearColor];
    
    [[UIApplication sharedApplication].keyWindow addSubview:cover];
    
    return cover;
}

// 点击蒙板的时候做事情

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    // 移除蒙板
    [self removeFromSuperview];
    // 通知代理移除菜单
    if ([_delegate respondsToSelector:@selector(coverDidClickCover:)]) {
        [_delegate coverDidClickCover:self];
    }
    
    
}




@end
