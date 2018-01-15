//
//  XDMyFacilityTwoCell.m
//  TrafficAPP
//
//  Created by xiao dou on 2017/10/30.
//  Copyright © 2017年 xiao dou. All rights reserved.
//

#import "XDMyFacilityTwoCell.h"
static NSString *XDMyFacilityTwoCellName = @"XDMyFacilityTwoCell";
@implementation XDMyFacilityTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    XDMyFacilityTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:XDMyFacilityTwoCellName];
    if (cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:XDMyFacilityTwoCellName owner:nil options:nil] lastObject];
        
    }    return cell;
}
- (void)setTitleStr:(NSString *)titleStr{
    self.titleLab.text = titleStr;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
