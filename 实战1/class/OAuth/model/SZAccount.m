//
//  SZAccount.m
//  实战1
//
//  Created by apple on 15/11/4.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SZAccount.h"

#define CZAccountTokenKey @"token"
#define CZUidKey @"uid"
#define CZExpires_inKey @"exoires"
#define CZExpires_dateKey @"date"

@implementation SZAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict{
    
    SZAccount *account = [[self alloc ]init];
    
    [account setValuesForKeysWithDictionary:dict];
    
    return account;
    
}

-(void)setExpires_in:(NSString *)expires_in{
    
    _expires_in = expires_in;
    
    // 计算过期的时间 = 当前时间 + 有效期
    _expires_date = [NSDate dateWithTimeIntervalSinceNow:[expires_in longLongValue]];
    
    
}
// 归档的时候调用：告诉系统哪个属性需要归档，如何归档

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:_access_token forKey:@"token"];
    [aCoder encodeObject:_expires_in forKey:@"exoires"];
    [aCoder encodeObject:_uid forKey:@"uid"];
    [aCoder encodeObject:_expires_date forKey:@"date"];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        
        // 一定要记得赋值
        _access_token = [aDecoder decodeObjectForKey:@"token"];
        _expires_in = [aDecoder decodeObjectForKey:@"exoires"];
        _uid = [aDecoder decodeObjectForKey:@"uid"];
        _expires_date = [aDecoder decodeObjectForKey:@"date"];

       
    }
    
    return self;
    
}

/**
 *  KVC底层实现：遍历字典里的所有key(uid)
 一个一个获取key，会去模型里查找setKey: setUid:,直接调用这个方法，赋值 setUid:obj
 寻找有没有带下划线_key,_uid ,直接拿到属性赋值
 寻找有没有key的属性，如果有，直接赋值
 在模型里面找不到对应的Key,就会报错.
 */


@end
