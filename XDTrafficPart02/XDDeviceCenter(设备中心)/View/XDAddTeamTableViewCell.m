//
//  XDAddTeamTableViewCell.m
//  TrafficAPP
//
//  Created by xiao dou on 2017/11/21.
//  Copyright © 2017年 xiao dou. All rights reserved.
//

#import "XDAddTeamTableViewCell.h"
static NSString *XDAddTeamTableViewCellName = @"XDAddTeamTableViewCell";
@implementation XDAddTeamTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    XDAddTeamTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:XDAddTeamTableViewCellName];
    if (cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:XDAddTeamTableViewCellName owner:nil options:nil] lastObject];
    }
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
