//
//  XDEditEquipmentViewController.h
//  XDTrafficPart02
//
//  Created by xiao dou on 2018/1/11.
//  Copyright © 2018年 xiao dou. All rights reserved.
//

#import "XDBaseViewController.h"
#import "XDSetInfoDetailModel.h"
@interface XDEditEquipmentViewController : XDBaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_bgTablview;
    NSMutableArray *_teamArray;
    XDSetInfoDetailModel *_setInfoModel;
}
@property (nonatomic,strong)EquipmentModel *model;
/**修改位置*/
@property (nonatomic,assign)NSInteger indexNum;
@property (nonatomic, copy)void (^editInfoBlcok) (EquipmentModel *modelObj);
@end
