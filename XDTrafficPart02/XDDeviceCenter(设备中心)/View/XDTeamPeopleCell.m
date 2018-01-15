//
//  XDTeamPeopleCell.m
//  TrafficAPP
//
//  Created by xiao dou on 2017/11/21.
//  Copyright © 2017年 xiao dou. All rights reserved.
//

#import "XDTeamPeopleCell.h"
static NSString *XDTeamPeopleCellName = @"XDTeamPeopleCell";
@implementation XDTeamPeopleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    XDTeamPeopleCell *cell = [tableView dequeueReusableCellWithIdentifier:XDTeamPeopleCellName];
    if (cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:XDTeamPeopleCellName owner:nil options:nil] lastObject];
        cell.headImageView.clipsToBounds = YES;
        cell.headImageView.layer.cornerRadius = 25;
    }
    return cell;
}
- (void)setUserModel:(XDUserModel *)userModel{
    if (!kStringIsEmpty(userModel.remark)) {
        self.nameLab.text =userModel.remark;
    }
   else if (!kStringIsEmpty(userModel.nick)) {
        self.nameLab.text =userModel.nick;
    }
   else{
        self.nameLab.text =userModel.mobile;
   }
    self.phoneLab.text = userModel.mobile;
    if ([userModel.role isEqualToString:@"admin"]==YES) {
        self.adminIconImg.hidden = NO;
    }
    else{
         self.adminIconImg.hidden = YES;
    }
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:userModel.icon] placeholderImage:PLACEHODELIMAGE];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end
