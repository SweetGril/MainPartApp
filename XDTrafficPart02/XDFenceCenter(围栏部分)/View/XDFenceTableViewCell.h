//
//  XDFenceTableViewCell.h
//  TrafficAPP
//
//  Created by xiao dou on 2017/8/9.
//  Copyright © 2017年 xiao dou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XDCricleModel.h"
@interface XDFenceTableViewCell : UITableViewCell
{
   
}
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**
 *编辑
 */
@property(copy,nonatomic) void (^editBlock)(NSInteger buttonTag);
/**
 *撤销
 */
@property (weak, nonatomic) IBOutlet UILabel *placeLab;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *cricleLab;
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic,strong)XDCricleModel *modelObject;
@end
