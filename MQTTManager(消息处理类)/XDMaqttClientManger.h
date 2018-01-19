//
//  XDMaqttClientManger.h
//  XDTrafficPart01
//
//  Created by xiao dou on 2018/1/9.
//  Copyright © 2018年 xiao dou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XDClientManager.h"
/**用于连接，接收消息的类库*/
@interface XDMaqttClientManger : NSObject<XDClientManagerDelegate>
+ (XDMaqttClientManger*)sharedInstance;
- (void)connectMqtt;
/**单条 设备取消订阅*/
- (void)unsubscriptSingleWithTopic:(NSString *)topicStr;
/**单条 订阅*/
- (void)subscriptionSingleWithTopic:(NSString *)topicStr;
@end
