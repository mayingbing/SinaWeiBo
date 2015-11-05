//
//  SZAccount.h
//  实战1
//
//  Created by apple on 15/11/4.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SZAccount : NSObject<NSCoding>


//返回值字段	字段类型	字段说明
//access_token	string	用于调用access_token，接口获取授权后的access token。
//expires_in	string	access_token的生命周期，单位是秒数。
//remind_in	string	access_token的生命周期（该参数即将废弃，开发者请使用expires_in）。
//uid	string	当前授权用户的UID。

/**
 *  获取数据的访问命令牌
 */

@property (nonatomic, copy) NSString *access_token;
/**
 *  账号的有效期
 */

@property (nonatomic, copy) NSString *expires_in;
/**
 *  用户唯一标识符
 */

@property (nonatomic, copy) NSString *uid;

/**
 *   过期时间 = 当前保存时间+有效期
 */
@property (nonatomic, strong) NSDate *expires_date;

/**
 *  账号的有效期
 */
@property (nonatomic, copy) NSString *remind_in;


+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
