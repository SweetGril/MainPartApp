//
//  XDFenceTableViewCell.m
//  TrafficAPP
//
//  Created by xiao dou on 2017/8/9.
//  Copyright © 2017年 xiao dou. All rights reserved.
//

#import "XDFenceTableViewCell.h"
// 定义一个重用标识
static NSString *XDFenceTableViewCellName = @"XDFenceTableViewCell";
@implementation XDFenceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    // 先去缓存池找可重用的cell
    XDFenceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:XDFenceTableViewCellName];
    // 如果缓存池没有可重用的cell,创建一个cell,并给cell绑定一个重用标识
    if (cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:XDFenceTableViewCellName owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setModelObject:(XDCricleModel *)modelObject
{
    self.titleLab.text =[NSString stringWithFormat:@"%@",modelObject.scopeName];
    self.placeLab.text = [NSString stringWithFormat:@"地址:%@",modelObject.location];
    self.cricleLab.text =[NSString stringWithFormat:@"半径:%@m",modelObject.deviceRadius];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
