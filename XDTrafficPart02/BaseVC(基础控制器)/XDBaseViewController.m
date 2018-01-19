//
//  XDBaseViewController.m
//  XDTrafficPart01
//
//  Created by xiao dou on 2018/1/5.
//  Copyright © 2018年 xiao dou. All rights reserved.
//

#import "XDBaseViewController.h"
#import "XDClientManager.h"
#import "XDMqttMessage.h"
@interface XDBaseViewController (){
    
}
@end

@implementation XDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设备移动
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(liveManagerDidReceiveMessage:) name:XDMoveReceiveMessageNotification object:nil];
    
    //设备修改
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceEditMessage:) name:XDChageDeviceNotification object:nil];
    //设备删除
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceDeleteMessage:) name:XDNotifatinDeviceDelete object:nil];
}
/**设备移动*/
-(void)liveManagerDidReceiveMessage:(NSNotification *)notifi{
}

/**设备发生编辑*/
-(void)deviceEditMessage:(NSNotification *)notifi{
}
/**
 设备删除
 1.主动；
 2.被动
 */
-(void)deviceDeleteMessage:(NSNotification *)notifi{
    
}


#pragma mark --提示框
- (void)showHUDHintWithText:(NSString *)text {
    if (!text) {
        return;
    }
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hub.mode = MBProgressHUDModeText;
    //    hub.labelText = text;
    hub.detailsLabelText = text;
    hub.removeFromSuperViewOnHide = YES;
    [hub show:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // Do something...
        dispatch_async(dispatch_get_main_queue(), ^{
            [hub hide:YES afterDelay:2];
        });
    });
}
/**加载框 */
- (void)showHUDLoading {
    [_loadingHub removeFromSuperview];
    _loadingHub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _loadingHub.mode = MBProgressHUDModeIndeterminate;
    _loadingHub.removeFromSuperViewOnHide = YES;
    [_loadingHub show:YES];
}
/**移除加载框 */
- (void)hideHUDLoading {
    [_loadingHub hide:YES];
}

- (void)dealloc{
    NSLog(@"----%s-dealloc-",__func__);
      [[NSNotificationCenter defaultCenter] removeObserver:self name:XDMoveReceiveMessageNotification object:nil];
      [[NSNotificationCenter defaultCenter] removeObserver:self name:XDChageDeviceNotification object:nil];
//     [[XDClloctionManager sharedManager] removeObserver:self forKeyPath:@"allDeviceDictionary"];
}
@end
