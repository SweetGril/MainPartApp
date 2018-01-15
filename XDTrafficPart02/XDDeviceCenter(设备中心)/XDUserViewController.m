//
//  XDUserViewController.m
//  TrafficAPP
//
//  Created by xiao dou on 2017/11/23.
//  Copyright © 2017年 xiao dou. All rights reserved.
//

#import "XDUserViewController.h"
#import "EquipmentModel.h"
@interface XDUserViewController ()
{
    NSString *nameStr;
}
@end

@implementation XDUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (!kStringIsEmpty(_userModel.remark)) {
        self.nameLab.text =_userModel.remark;
    }
    else if (!kStringIsEmpty(_userModel.nick)) {
        self.nameLab.text =_userModel.nick;
    }
    else{
        self.nameLab.text =_userModel.mobile;
    }
    nameStr = self.nameLab.text;
    _relieveBtn.clipsToBounds = YES;
    _relieveBtn.layer.cornerRadius =8;
    
    //查看人的身份为管理员
    if ([_userModel.role isEqualToString:@"admin"]==YES) {
        _hideViewShow.hidden =NO;
        _relieveBtn.hidden = YES;
        if (_isOnlyOne ==YES) {
           _relieveBtn.hidden = NO;
        }
    }
    else{
        if ([_model.role isEqualToString:@"admin"]==YES) {
            _hideViewShow.hidden =YES;
            _relieveBtn.hidden = NO;
        }
        else{
            _hideViewShow.hidden =NO;
            _relieveBtn.hidden = YES;
        }
    }
    self.navigationItem.title = self.nameLab.text;
    self.phoneLab.text =_userModel.mobile;
    self.headImageView.clipsToBounds = YES;
    self.headImageView.layer.cornerRadius =25;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:_userModel.icon] placeholderImage:PLACEHODELIMAGE];
    self.emailLab.text = @"----------";
    self.sexLab.text = @"--";
    self.view.backgroundColor =[UIColor colorWithHexString:@"#f0f0f0"];
}

- (IBAction)editBtnClick:(id)sender {
    _nameLab.userInteractionEnabled = YES;
    [_nameLab becomeFirstResponder];
}
#pragma mark 解除绑定
- (IBAction)relieveBtnClick:(id)sender {
    
    NSString *url =[NSString stringWithFormat:@"%@/device/unbind",APIHEADStr];
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] init];
    [dataDic setValue:_model.deviceId forKey:@"deviceId"];
     [dataDic setValue:_userModel.mobile forKey:@"mobile"];
    __weak typeof(self) weakSelf = self;
    [[XDNetWork sharedInstance]postRequestWithUrl:url andParameters:dataDic success:^(NSDictionary *success) {
        if ([success[@"code"] intValue]==200) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *failure) {
    }];
}

//实现UITextField代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (!kStringIsEmpty(_nameLab.text)) {
        [textField resignFirstResponder];//取消第一响应者
        textField.userInteractionEnabled = NO;
        [self editUserName];
    }
    else{
        [self showHUDHintWithText:@"备注名称不能为空"];
    }
    return YES;
}
#pragma mark 编辑名称
- (void)editUserName{
    NSString *url =[NSString stringWithFormat:@"%@/user/remark",APIHEADStr];
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] init];
    [dataDic setValue:_userModel.mobile forKey:@"mobile"];
    [dataDic setValue:_nameLab.text forKey:@"remark"];
    [[XDNetWork sharedInstance]postRequestWithUrl:url andParameters:dataDic success:^(NSDictionary *success) {
        if ([success[@"code"] intValue]==200){
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *failure) {
        
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    _nameLab.userInteractionEnabled = NO;
    self.nameLab.text  = nameStr;
}
- (IBAction)switchBtnclick:(id)sender {
    NSString *url =[NSString stringWithFormat:@"%@/device/admin/to",APIHEADStr];
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] init];
    [dataDic setValue:_model.deviceId forKey:@"deviceId"];
    [dataDic setValue:_userModel.mobile forKey:@"mobile"];
    __weak typeof(self) weakSelf = self;
    [[XDNetWork sharedInstance]postRequestWithUrl:url andParameters:dataDic success:^(NSDictionary *success) {
        if ([success[@"code"] intValue]==200) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *failure) {
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    
}
@end
