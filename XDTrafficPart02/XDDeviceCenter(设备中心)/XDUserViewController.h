//
//  XDUserViewController.h
//  TrafficAPP
//
//  Created by xiao dou on 2017/11/23.
//  Copyright © 2017年 xiao dou. All rights reserved.
//

#import "XDBaseViewController.h"
#import "XDUserModel.h"
#import "XDSetInfoDetailModel.h"
/**查看成员的信息页面*/
@interface XDUserViewController : XDBaseViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) IBOutlet UITextField *nameLab;
@property (strong, nonatomic) IBOutlet UILabel *phoneLab;
@property (strong, nonatomic) IBOutlet UILabel *emailLab;
@property (strong, nonatomic) IBOutlet UIButton *editBtn;
@property (strong, nonatomic) IBOutlet UILabel *sexLab;
/**解除绑定*/
@property (strong, nonatomic) IBOutlet UIButton *relieveBtn;
@property (strong, nonatomic) IBOutlet UIView *hideViewShow;

@property (nonatomic, strong)XDUserModel *userModel;
@property (nonatomic, strong) XDSetInfoDetailModel *model;
/**修改位置*/
@property (nonatomic,assign)NSInteger indexNum;
/**设备管理人员只有一个人，允许管理员直接要移除设备*/
@property (nonatomic,assign)BOOL isOnlyOne;
@end
