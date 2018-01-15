//
//  XDAddTeamViewController.m
//  TrafficAPP
//
//  Created by xiao dou on 2017/11/21.
//  Copyright © 2017年 xiao dou. All rights reserved.
//

#import "XDAddTeamViewController.h"
#import <ContactsUI/ContactsUI.h>
@interface XDAddTeamViewController ()<CNContactPickerDelegate>

@end

@implementation XDAddTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"邀请新用户";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    _sendBtn.clipsToBounds = YES;
    _sendBtn.layer.cornerRadius = 8;
}

- (IBAction)phoneNumBtnClick:(UIButton *)sender {

    CNContactPickerViewController * contactVc = [CNContactPickerViewController new];
    contactVc.delegate = self;
    contactVc.displayedPropertyKeys = @[CNContactPhoneNumbersKey];//只显示手机号
    UIWindow *window =[UIApplication sharedApplication].keyWindow;
    [window.rootViewController presentViewController:contactVc animated:YES completion:nil];
}
- (IBAction)senBtnCLick:(id)sender {
    
    if (kStringIsEmpty(_phoneTextField.text)) {
        [self showHUDHintWithText:@"请填写手机号码"];
        return;
    }
    NSString *url =[NSString stringWithFormat:@"%@/sms/invite",APIHEADStr];
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] init];
    [dataDic setValue:_phoneTextField.text forKey:@"mobile"];
    [dataDic setValue:_model.deviceId forKey:@"deviceId"];
    [dataDic setValue:[NSString stringWithFormat:@"%d",_model.deviceType] forKey:@"deviceType"];
    [dataDic setValue:_model.deviceName forKey:@"deviceName"];
    
    [[XDNetWork sharedInstance]postRequestWithUrl:url andParameters:dataDic success:^(NSDictionary *success) {
        if ([success[@"code"] intValue]==200){
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [self showHUDHintWithText:success[@"status"]];
        }
    } failure:^(NSError *failure) {
        
    }];
}
// 选择某个联系人时调用
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty
{
    CNContact *contact = contactProperty.contact;
    NSString *name = [CNContactFormatter stringFromContact:contact style:CNContactFormatterStyleFullName];
    CNPhoneNumber *phoneValue= contactProperty.value;
    NSString *phoneNumber = phoneValue.stringValue;
    NSLog(@"%@--%@",name, phoneNumber);
    _nameTextField.text = name;
    _phoneTextField.text = phoneNumber;
}
- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)dealloc{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
