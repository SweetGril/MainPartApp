//
//  XDElectronVFenceListVC.h
//  TrafficAPP
//
//  Created by xiao dou on 2017/8/9.
//  Copyright © 2017年 xiao dou. All rights reserved.
//

#import "XDBaseViewController.h"
//#import "XDSelectView.h"
@interface XDElectronVFenceListVC : XDBaseViewController<UITableViewDelegate,UITableViewDataSource>
@property(copy,nonatomic) void (^addressBlock)(NSString * addressStr);
//设备选择
//@property (strong,nonatomic) XDSelectView *selectBottomview;
//@property (strong,nonatomic)NSMutableArray *allInfoArray;
@property (strong,nonatomic) UITableView *bgTableView;
@end
