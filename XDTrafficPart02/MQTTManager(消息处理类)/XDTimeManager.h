//
//  XDTimeManager.h
//  XDTrafficPart02
//
//  Created by xiao dou on 2018/1/12.
//  Copyright © 2018年 xiao dou. All rights reserved.
//

#import <Foundation/Foundation.h>
/**进行时间戳展示相关的类*/
@interface XDTimeManager : NSObject
/**
 根据时间戳计算时间显示 yyyy-MM-dd HH:mm:ss
 */
+ (NSString *)timeWithMoreString:(NSString *)timeStr;
/**
 根据时间戳计算时间显示 yyyy-MM-dd HH:00
 */
+ (NSString *)timeWithString:(NSString *)timeStr;
@end
