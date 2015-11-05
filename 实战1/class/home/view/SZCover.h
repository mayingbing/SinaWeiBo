//
//  SZCover.h
//  实战1
//
//  Created by apple on 15/10/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SZCover;
@protocol SZCoverDelegate <NSObject>

@optional
// 点击蒙板的时候调用
-(void)coverDidClickCover:(SZCover *)cover;

@end


@interface SZCover : UIView
/**
 *  显示蒙板
 */
+(instancetype)show;



@property (nonatomic, assign) BOOL dimBackground;
@property (nonatomic, weak) id<SZCoverDelegate>delegate;

@end
