//
//  XDFenceTableViewTwoCell.h
//  TrafficAPP
//
//  Created by xiao dou on 2017/9/15.
//  Copyright © 2017年 xiao dou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XDCricleModel.h"
@interface XDFenceTableViewTwoCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *fanceNameLab;
@property (strong, nonatomic) IBOutlet UILabel *placeLab;
@property (nonatomic,strong)XDCricleModel *modelObject;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
