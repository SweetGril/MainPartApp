//
//  XDBaseViewController.h
//  XDTrafficPart01
//
//  Created by xiao dou on 2018/1/5.
//  Copyright © 2018年 xiao dou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface XDBaseViewController : UIViewController
@property (nonatomic,strong) MBProgressHUD *loadingHub;
/**设备移动*/
-(void)liveManagerDidReceiveMessage:(NSNotification *)notifi;
/**设备发生编辑*/
-(void)deviceEditMessage:(NSNotification *)notifi;
/**
 设备删除
 1.主动；
 2.被动
 */
-(void)deviceDeleteMessage:(NSNotification *)notifi;
#pragma mark --提示框
- (void)showHUDHintWithText:(NSString *)text;
/**加载框 */
- (void)showHUDLoading;
/**移除加载框 */
- (void)hideHUDLoading;
@end
