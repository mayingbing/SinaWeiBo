//
//  SZAccountTool.h
//  实战1
//
//  Created by apple on 15/11/4.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SZAccount;

@interface SZAccountTool : NSObject<NSCoding>


+ (void)saveAccount:(SZAccount *)account;

+ (SZAccount *)account;

@end
