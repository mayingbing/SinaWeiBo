//
//  SZAccountTool.m
//  实战1
//
//  Created by apple on 15/11/4.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SZAccountTool.h"
#import "SZAccount.h"

#define CZAccountFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

@implementation SZAccountTool

// 类方法一般用静态变量代替成员属性

static SZAccount *_account;

+(void)saveAccount:(SZAccount *)account{

    [NSKeyedArchiver archiveRootObject:account toFile:CZAccountFileName];
}

+(SZAccount *)account{
    
    if (_account == nil) {
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:CZAccountFileName];
        
        // 判断下账号是否过期，如果过期直接返回Nil
        // 2015 < 2017
        
        if ([[NSDate date] compare:_account.expires_date] != NSOrderedAscending) {
            return nil;
        }
        
    }
    
    return _account;
}


@end
