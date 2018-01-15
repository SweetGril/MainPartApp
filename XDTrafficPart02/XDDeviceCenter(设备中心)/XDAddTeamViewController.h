//
//  XDAddTeamViewController.h
//  TrafficAPP
//
//  Created by xiao dou on 2017/11/21.
//  Copyright © 2017年 xiao dou. All rights reserved.
//

#import "XDBaseViewController.h"
#import "XDSetInfoDetailModel.h"
@interface XDAddTeamViewController : XDBaseViewController
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *phoneTextField;
@property (strong, nonatomic) IBOutlet UIButton *sendBtn;
@property (nonatomic, strong) XDSetInfoDetailModel *model;
@end
