//
//  XDMyFacilityTableViewCell.h
//  TrafficAPP
//
//  Created by xiao dou on 2017/10/30.
//  Copyright © 2017年 xiao dou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EquipmentModel.h"
@interface XDMyFacilityTableViewCell : UITableViewCell<UITextFieldDelegate>
@property (nonatomic,strong)NSString *titleStr;
@property (nonatomic,strong)NSString *contentStr;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UITextField *contentField;
@property (nonatomic,strong)EquipmentModel *modelObject;
/**修改位置*/
@property (nonatomic,assign)NSInteger indexNum;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
