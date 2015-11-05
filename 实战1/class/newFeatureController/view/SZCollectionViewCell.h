//
//  SZCollectionViewCell.h
//  实战1
//
//  Created by apple on 15/11/1.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *image;
// 判断是否是最后一页
- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count;

@end
