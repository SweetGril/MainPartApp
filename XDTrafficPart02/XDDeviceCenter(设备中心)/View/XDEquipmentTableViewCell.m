//
//  XDEquipmentTableViewCell.m
//  TrafficAPP
//
//  Created by xiao dou on 2017/8/8.
//  Copyright © 2017年 xiao dou. All rights reserved.
//

#import "XDEquipmentTableViewCell.h"
// 定义一个重用标识
static NSString *XDEquipmentTableViewCellName = @"XDEquipmentTableViewCell";

@implementation XDEquipmentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    // 先去缓存池找可重用的cell
    XDEquipmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:XDEquipmentTableViewCellName];
    // 如果缓存池没有可重用的cell,创建一个cell,并给cell绑定一个重用标识
    if (cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:XDEquipmentTableViewCellName owner:nil options:nil] lastObject];
        cell.titleField.returnKeyType = UIReturnKeyDone;
    }
    return cell;
}
- (void)setModelObject:(EquipmentModel *)modelObject{
    _modelObject =modelObject;
    self.titleField.text =[NSString stringWithFormat:@"%@",modelObject.deviceName];
    self.timeLab.text = [NSString stringWithFormat:@"%@",modelObject.time];
    self.placeLab.text = modelObject.placeStr;
    self.contentLab.text = [NSString stringWithFormat:@"%@",modelObject.deviceId];
    if ([_modelObject.status isEqualToString:@"offline"]==YES) {
        self.statusLab.text = @"离线";
    }
    else{
        self.statusLab.text = @"在线";
    }
    
    if (_modelObject.deviceType==1) {
        self.typeImageView.image =[UIImage imageNamed:@"CarIcon"];
    }
    else if (_modelObject.deviceType==2){
         self.typeImageView.image =[UIImage imageNamed:@"electrombile"];
    }
    else{
        self.typeImageView.image =[UIImage imageNamed:@"Group_icon"];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
