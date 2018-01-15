//
//  XDSelectTypeEquipmentCell.h
//  TrafficAPP
//
//  Created by xiao dou on 2017/10/30.
//  Copyright © 2017年 xiao dou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EquipmentModel.h"
@interface XDSelectTypeEquipmentCell : UITableViewCell
{
    UIButton *selectBtn;
    EquipmentModel *_model;
}
/**修改位置*/
@property (nonatomic,assign)NSInteger indexNum;
@property (strong, nonatomic) IBOutlet UIButton *carTypeBtn;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (nonatomic,strong)NSString *titleStr;
@property (nonatomic,strong)EquipmentModel *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
