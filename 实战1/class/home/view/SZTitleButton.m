//
//  SZTitleButton.m
//  实战1
//
//  Created by apple on 15/10/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SZTitleButton.h"
#import "UIImage+Image.h"
#import "UIView+Frame.h"

@implementation SZTitleButton


-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor blackColor ] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageWithStretchableName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    }
    return  self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    if (self.currentImage == nil) {
        return;
    }
    
    self.titleLabel.x =self.imageView.x;
    
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
    
   }

-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    
    [super setTitle:title forState:state];
    
    [self sizeToFit];
    
}

-(void)setImage:(UIImage *)image forState:(UIControlState)state{
    
    [super setImage:image forState:state];
    [self sizeToFit];
    
}

@end
