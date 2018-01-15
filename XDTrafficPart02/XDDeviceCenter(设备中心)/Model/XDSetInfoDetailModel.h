//
//  XDSetInfoDetailModel.h
//  TrafficAPP
//
//  Created by xiao dou on 2017/8/17.
//  Copyright © 2017年 xiao dou. All rights reserved.
//

#import <Foundation/Foundation.h>
//bindTime = 1511415323695;
//deviceId = "10001-09-0A-10A5C3872";
//deviceName = "\U51c4\U51c4\U5207\U5207\U9f50\U5168";
//mobile = 13625811915;
//role = admin;
//deviceType = 1;
@interface XDSetInfoDetailModel : NSObject
@property (nonatomic,strong)NSString * bindTime;
@property (nonatomic,strong)NSString * deviceId;
@property (nonatomic,strong)NSString * deviceName;
@property (nonatomic,strong)NSString * mobile;
@property (nonatomic,strong)NSString * role;
@property(nonatomic,assign) int  deviceType;
@end
