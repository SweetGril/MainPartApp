//
//  XDFenceTableViewTwoCell.m
//  TrafficAPP
//
//  Created by xiao dou on 2017/9/15.
//  Copyright © 2017年 xiao dou. All rights reserved.
//

#import "XDFenceTableViewTwoCell.h"
#import "XDCricleModel.h"
// 定义一个重用标识
static NSString *XDFenceTableViewTwoCellName = @"XDFenceTableViewTwoCell";
@implementation XDFenceTableViewTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    // 先去缓存池找可重用的cell
    XDFenceTableViewTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:XDFenceTableViewTwoCellName];
    // 如果缓存池没有可重用的cell,创建一个cell,并给cell绑定一个重用标识
    if (cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:XDFenceTableViewTwoCellName owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setModelObject:(XDCricleModel *)modelObject{
    self.fanceNameLab.text =[NSString stringWithFormat:@"%@",modelObject.scopeName];
    self.placeLab.text = [NSString stringWithFormat:@"地址:%@",modelObject.location];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
