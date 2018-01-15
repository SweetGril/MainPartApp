//
//  XDEquipmentList.m
//  XDTrafficPart02
//
//  Created by xiao dou on 2018/1/11.
//  Copyright © 2018年 xiao dou. All rights reserved.
//

#import "XDEquipmentList.h"
#import "EquipmentModel.h"
#import "XDMonitoViewController.h"
#import "XDEquipmentTableViewCell.h"
#import "XDEditEquipmentViewController.h"
@interface XDEquipmentList ()

@end

@implementation XDEquipmentList

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [[XDDeviceManager sharedManager] addObserver:self forKeyPath:@"changeDeviceTopic" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [[XDDeviceManager sharedManager] addObserver:self forKeyPath:@"changePlaceTopic" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    [[XDDeviceManager sharedManager] postDeviceListsuccess:^(NSDictionary *success) {
        [self creatView];
     
    } failure:^(NSError *failure) {
    }];
   
  
}
-(void)creatView{
    self.navigationItem.title = @"我的设备";
    _bgTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    _bgTableView.delegate = self;
    _bgTableView.dataSource = self;
    _bgTableView.backgroundColor  =[UIColor colorWithHexString:@"#f0f0f0"];
    _bgTableView.estimatedRowHeight = 0;
    _bgTableView.estimatedSectionHeaderHeight = 0;
    _bgTableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:_bgTableView];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([XDDeviceManager sharedManager].allDeviceKeyArray.count==0||[XDDeviceManager sharedManager].allDeviceKeyArray ==nil) {
        return 0;
    }
    return [XDDeviceManager sharedManager].allDeviceKeyArray.count;
}
#pragma mark - 初始化Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XDEquipmentTableViewCell * rCell = [XDEquipmentTableViewCell cellWithTableView:tableView];
    rCell.indexPath = indexPath;
    [self configHotCell:rCell atIndexPath:indexPath];
    return rCell;
}
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    UITableViewRowAction *editRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@" 设置 "handler:^(UITableViewRowAction *action,NSIndexPath *indexPath) {
        NSLog(@"编辑选定");
        [weakSelf editTitle:indexPath];
    }];
    editRowAction.backgroundColor = [UIColor colorWithHexString:@"#F5A623"];
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@" 删除 "handler:^(UITableViewRowAction *action,NSIndexPath *indexPath) {
        
        NSLog(@"解绑选定");
        [weakSelf deleteData:indexPath];
    }];
    deleteRowAction.backgroundColor = [UIColor colorWithHexString:@"#FF0000"];
    return @[deleteRowAction,editRowAction];
}

#pragma mark - 设置Cell内容
-(void)configHotCell:(XDEquipmentTableViewCell *)cell atIndexPath:(NSIndexPath*)indexPath
{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    EquipmentModel *modelObject = [[XDDeviceManager sharedManager]getModelWithIndex:indexPath.row];
    cell.modelObject = modelObject;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isEdit ==YES) {
        [self endEditFun];
        return;
    }
   
    EquipmentModel *modelObject = [[XDDeviceManager sharedManager]getModelWithIndex:indexPath.row];
    UINavigationController * nav = [self.tabBarController.viewControllers objectAtIndex:0];
    for (UIViewController *vc in nav.viewControllers) {
        if ([vc isKindOfClass:[XDMonitoViewController class]] ) {
            XDMonitoViewController *objVc = (XDMonitoViewController *)vc;
            [objVc selectAnnotationViewWithModel:modelObject];
        }
    }
    self.tabBarController.selectedViewController = nav;

}


/*2.实现回调方法*/
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id>*)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"changeDeviceTopic"]==YES) {
        [_bgTableView reloadData];
    }

    if ([keyPath isEqualToString:@"changePlaceTopic"]==YES) {
         [_bgTableView reloadData];
    }
}

#pragma mark 解绑设备
-(void)deleteData:(NSIndexPath *)indexPath{
    EquipmentModel *model = [[XDDeviceManager sharedManager]getModelWithIndex:indexPath.row];
    NSString *url =[NSString stringWithFormat:@"%@/device/unbind",APIHEADStr];
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] init];
    [dataDic setValue:model.deviceId forKey:@"deviceId"];
    __weak typeof(self) weakSelf = self;
    [[XDNetWork sharedInstance]postRequestWithUrl:url andParameters:dataDic success:^(NSDictionary *success) {
        if ([success[@"code"] intValue]==200) {
            
            NSMutableArray *resultArray = [XDDeviceManager sharedManager].allDeviceKeyArray;
            NSString *keyStr = resultArray[indexPath.row];
            
            [[XDDeviceManager sharedManager].allDeviceKeyArray removeObjectAtIndex:indexPath.row];
            [[XDDeviceManager sharedManager].allDeviceDictionary removeObjectForKey:keyStr];
            [[NSNotificationCenter defaultCenter] postNotificationName:XDNotifatinDeviceDelete object:nil];
            [weakSelf.bgTableView reloadData];
        }
        else{
            [self showHUDHintWithText:success[@"status"]];
        }
    } failure:^(NSError *failure) {
        
    }];
}
#pragma mark 编辑设备名称
- (void)editTitle:(NSIndexPath *)indexPath{
    [_bgTableView setEditing:NO];
    selectObjIndex = indexPath;

    EquipmentModel *modelObject = [[XDDeviceManager sharedManager]getModelWithIndex:indexPath.row];
    XDEditEquipmentViewController *vc =[[XDEditEquipmentViewController alloc] init];
    vc.title = modelObject.deviceName;
    vc.indexNum = indexPath.row;
    vc.model = modelObject;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)endEditFun{
    [self.view endEditing:YES];
    isEdit = NO;
    EquipmentModel *model = [[XDDeviceManager sharedManager] getModelWithIndex:selectObjIndex.row];
    XDEquipmentTableViewCell *selectCell = (XDEquipmentTableViewCell *)[_bgTableView cellForRowAtIndexPath:selectObjIndex];
    selectCell.titleField.text = model.deviceName;
    selectCell.titleField.userInteractionEnabled = NO;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditFun];
}
#pragma mark 设备消息接收
-(void)liveManagerDidReceiveMessage:(NSNotification *)notifi{
    
}
- (void)dealloc{
    [[XDDeviceManager sharedManager] removeObserver:self forKeyPath:@"changeDeviceTopic" context:nil];
    NSLog(@"=XDEquipmentList====释放了");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
