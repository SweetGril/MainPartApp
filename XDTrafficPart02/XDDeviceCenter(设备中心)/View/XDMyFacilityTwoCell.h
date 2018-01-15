//
//  XDMyFacilityTwoCell.h
//  TrafficAPP
//
//  Created by xiao dou on 2017/10/30.
//  Copyright © 2017年 xiao dou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XDMyFacilityTwoCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (nonatomic,strong)NSString *titleStr;
/**修改位置*/
@property (nonatomic,assign)NSInteger indexNum;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
