//
//  XDMyFacilityTableViewCell.m
//  TrafficAPP
//
//  Created by xiao dou on 2017/10/30.
//  Copyright © 2017年 xiao dou. All rights reserved.
//

#import "XDMyFacilityTableViewCell.h"
// 定义一个重用标识
static NSString *XDMyFacilityTableViewCellName = @"XDMyFacilityTableViewCell";
@implementation XDMyFacilityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    XDMyFacilityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:XDMyFacilityTableViewCellName];
    if (cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:XDMyFacilityTableViewCellName owner:nil options:nil] lastObject];
        
    }
    return cell;
}
- (void)setTitleStr:(NSString *)titleStr{
    self.titleLab.text = titleStr;
}
- (void)setContentStr:(NSString *)contentStr{
    self.contentField.text = contentStr;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//实现UITextField代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    
    [textField resignFirstResponder];//取消第一响应者
//    textField.userInteractionEnabled = NO;
    [self keepTitleWithNssString:textField.text];
    return YES;
}

#pragma mark 编辑设备名称保存
- (void)keepTitleWithNssString:(NSString *)titleStr
{
    NSString *url =[NSString stringWithFormat:@"%@/device/update",APIHEADStr];
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] init];
    [dataDic setValue:_modelObject.deviceId forKey:@"deviceId"];
    [dataDic setValue:titleStr forKey:@"deviceName"];
    [[XDNetWork sharedInstance]postRequestWithUrl:url andParameters:dataDic success:^(NSDictionary *success) {
        if ([success[@"code"] intValue]==200) {
            _modelObject.deviceName =titleStr;
            [XDDeviceManager sharedManager].changeDeviceTopic = _modelObject.realTopic;
        }
    } failure:^(NSError *failure) {
    }];
}
@end
