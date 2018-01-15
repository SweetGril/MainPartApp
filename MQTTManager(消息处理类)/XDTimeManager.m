//
//  XDTimeManager.m
//  XDTrafficPart02
//
//  Created by xiao dou on 2018/1/12.
//  Copyright © 2018年 xiao dou. All rights reserved.
//

#import "XDTimeManager.h"
/**进行时间戳展示相关的类*/
@implementation XDTimeManager
/**
 根据时间戳计算时间显示 yyyy-MM-dd HH:mm:ss
 */
+ (NSString *)timeWithMoreString:(NSString *)timeStr
{
    if ([timeStr isEqualToString:@"4133952000000"]==YES) {
        return @"永久有效";
    }
    NSString * timeStampString = timeStr;
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return  [objDateformat stringFromDate: date];
}
/**
 根据时间戳计算时间显示 yyyy-MM-dd HH:00
 */
+ (NSString *)timeWithString:(NSString *)timeStr
{
    if ([timeStr isEqualToString:@"4133952000000"]==YES) {
        return @"永久有效";
    }
    NSString * timeStampString = timeStr;
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:00"];
    return  [objDateformat stringFromDate: date];
}
@end
