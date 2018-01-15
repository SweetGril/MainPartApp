//
//  XDEquipmentTableViewCell.h
//  TrafficAPP
//
//  Created by xiao dou on 2017/8/8.
//  Copyright © 2017年 xiao dou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EquipmentModel.h"
@interface XDEquipmentTableViewCell : UITableViewCell<UITextFieldDelegate>
{
    EquipmentModel *_modelObject;
}
@property (strong, nonatomic) IBOutlet UILabel *statusLab;
@property (strong, nonatomic) IBOutlet UIImageView *typeImageView;
@property (strong, nonatomic) IBOutlet UILabel *placeLab;

@property (strong, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong)EquipmentModel *modelObject;
@property (nonatomic,strong)NSIndexPath *indexPath;

@end
