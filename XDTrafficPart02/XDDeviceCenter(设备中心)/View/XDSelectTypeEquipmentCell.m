//
//  XDSelectTypeEquipmentCell.m
//  TrafficAPP
//
//  Created by xiao dou on 2017/10/30.
//  Copyright © 2017年 xiao dou. All rights reserved.
//

#import "XDSelectTypeEquipmentCell.h"
// 定义一个重用标识
static NSString *XDSelectTypeEquipmentCellName = @"XDSelectTypeEquipmentCell";
@implementation XDSelectTypeEquipmentCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    XDSelectTypeEquipmentCell *cell = [tableView dequeueReusableCellWithIdentifier:XDSelectTypeEquipmentCellName];
    if (cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:XDSelectTypeEquipmentCellName owner:nil options:nil] lastObject];
    }
    return cell;
}
- (void)setTitleStr:(NSString *)titleStr{
    self.titleLab.text =titleStr;
}
- (IBAction)typeBtnClick:(UIButton *)sender {
    selectBtn.selected = NO;
    selectBtn = sender;
    selectBtn.selected = YES;
    NSString *url =[NSString stringWithFormat:@"%@/device/update",APIHEADStr];
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] init];
    NSString *typeStr =[NSString stringWithFormat:@"%ld",sender.tag];
    [dataDic setValue:_model.deviceId forKey:@"deviceId"];
    [dataDic setValue:typeStr forKey:@"deviceType"];
//      __weak typeof(self) weakSelf = self;
    [[XDNetWork sharedInstance]postRequestWithUrl:url andParameters:dataDic success:^(NSDictionary *success) {
        if ([success[@"code"] intValue]==200) {
            _model.deviceType = sender.tag;
            [XDDeviceManager sharedManager].changeDeviceTopic = _model.realTopic;
        }
    } failure:^(NSError *failure) {
        
    }];
}
- (void)setModel:(EquipmentModel *)model{
    _model = model;
    selectBtn = (UIButton *)[self viewWithTag:model.deviceType];
    selectBtn.selected=YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
