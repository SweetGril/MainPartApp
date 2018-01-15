//
//  XDEquipmentList.h
//  XDTrafficPart02
//
//  Created by xiao dou on 2018/1/11.
//  Copyright © 2018年 xiao dou. All rights reserved.
//

#import "XDBaseViewController.h"

@interface XDEquipmentList : XDBaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    BOOL isEdit;//是否进行文字编辑中
    NSIndexPath * selectObjIndex; //选中编辑的cell 索引
}
@property (nonatomic,strong)UITableView *bgTableView;
@end
