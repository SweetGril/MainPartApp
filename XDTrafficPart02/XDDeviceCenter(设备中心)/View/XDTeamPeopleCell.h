//
//  XDTeamPeopleCell.h
//  TrafficAPP
//
//  Created by xiao dou on 2017/11/21.
//  Copyright © 2017年 xiao dou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XDUserModel.h"
@interface XDTeamPeopleCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
@property (nonatomic, strong)XDUserModel *userModel;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UILabel *phoneLab;
@property (strong, nonatomic) IBOutlet UIImageView *adminIconImg;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
