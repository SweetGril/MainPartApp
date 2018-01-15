//
//  XDEditEquipmentViewController.m
//  XDTrafficPart02
//
//  Created by xiao dou on 2018/1/11.
//  Copyright © 2018年 xiao dou. All rights reserved.
//

#import "XDEditEquipmentViewController.h"
#import "XDAddTeamViewController.h"
#import "XDUserViewController.h"
#import "XDSelectTypeEquipmentCell.h"
#import "XDMyFacilityTableViewCell.h"
#import "XDAddTeamTableViewCell.h"
#import "XDMyFacilityTwoCell.h"
#import "XDTeamPeopleCell.h"
@interface XDEditEquipmentViewController ()
{
    NSArray *_titleArray;
}
@end
@implementation XDEditEquipmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _teamArray = [[NSMutableArray alloc] init];
    _bgTablview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    _bgTablview.delegate = self;
    _bgTablview.dataSource = self;
    _bgTablview.estimatedRowHeight = 0;
    _bgTablview.estimatedSectionHeaderHeight = 0;
    _bgTablview.estimatedSectionFooterHeight = 0;
    [self.view addSubview:_bgTablview];
    
    NSArray *typeName1 = @[@"设备类型:",@"设备名称:",@"上报时间:"];
    NSArray *typeName2 = @[@"围栏告警",@"低电告警",@"震动告警",@"插拔告警"];
    NSArray *typeName3 = @[@"SIM卡号",@"SIM类型",@"网络制式",@"剩余流量"];
    NSArray *typeName4 = @[@"绑定时间"];
    _titleArray =[NSArray arrayWithObjects:typeName1,@"",typeName2,typeName3,typeName4, nil];
    [self requestInfoDataWithDeviceId:_model.deviceId];
    [self requestUserList];
 
}
- (void)viewWillAppear:(BOOL)animated{
    if (_bgTablview!=nil) {
        [self requestInfoDataWithDeviceId:_model.deviceId];
        [self requestUserList];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 3;
    }
    else if (section==1){
        if (_teamArray.count!=0) {
            return _teamArray.count+1;
        }
        return 1;
    }
    else if (section==2){
        return 4;
    }
    else if (section ==3){
        return 4;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0&&indexPath.row==0) {
        return 52;
    }
    if (indexPath.section ==1) {
        if (indexPath.row==_teamArray.count||_teamArray.count==0) {
            return 50;
        }
        return 68;
    }
    return 42;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==3) {
        return 0.1;
    }
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 20;
    }
    if (section==1) {
        return 30;
    }
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==1) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 2)];
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 120, 30)];
        titleLab.text = @"设备用户";
        titleLab.textColor = [UIColor colorWithHexString:@"#c0c0c0"];
        titleLab.font = [UIFont systemFontOfSize:12];
        [headView addSubview:titleLab];
        return headView;
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 2)];
    footView.backgroundColor =RGB(221, 221, 221);
    return footView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.row==0) {
        XDSelectTypeEquipmentCell * rCell = [XDSelectTypeEquipmentCell cellWithTableView:tableView];
        [self configHotCell:rCell atIndexPath:indexPath];
        rCell.model = self.model;
        rCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return rCell;
    }
    else if (indexPath.section==1){
        
        if (indexPath.row == _teamArray.count||_teamArray.count==0) {
            XDAddTeamTableViewCell *cell =[XDAddTeamTableViewCell cellWithTableView:tableView];
            return cell;
        }
        else{
            XDTeamPeopleCell *cell = [XDTeamPeopleCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [self creatUserCell:cell atIndexPath:indexPath];
            return cell;
        }
    }
    else if (indexPath.section ==2){
        XDMyFacilityTwoCell *cell =[XDMyFacilityTwoCell cellWithTableView:tableView];
        [self creatCellTowCell:cell atIndexPath:indexPath];
        return cell;
        
    }
    else {
        XDMyFacilityTableViewCell * cell =[XDMyFacilityTableViewCell cellWithTableView:tableView];
        cell.modelObject = self.model;
        [self creatCellThreeCell:cell atIndexPath:indexPath];
        return cell;
    }
    return nil;
}
#pragma mark - 设置Cell内容
-(void)configHotCell:(XDSelectTypeEquipmentCell *)cell atIndexPath:(NSIndexPath*)indexPath{
    NSArray *sectionTitleArray= _titleArray[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexNum =_indexNum;
    cell.titleStr = sectionTitleArray[indexPath.row];
}
- (void)creatCellTowCell:(XDMyFacilityTwoCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    NSArray *sectionTitleArray= _titleArray[indexPath.section];
    cell.titleStr = sectionTitleArray[indexPath.row];
    cell.indexNum =_indexNum;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}
#pragma mark 设备组员的cell
- (void)creatUserCell:(XDTeamPeopleCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    cell.userModel = _teamArray[indexPath.row];
}
- (void)creatCellThreeCell:(XDMyFacilityTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *sectionTitleArray= _titleArray[indexPath.section];
    cell.titleStr = sectionTitleArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexNum =_indexNum;
    if (indexPath.section ==0&&indexPath.row==1) {
        cell.contentStr =_setInfoModel.deviceName;
        cell.contentField.userInteractionEnabled = YES;
    }
    else if (indexPath.section ==0&&indexPath.row==2){
        cell.contentStr =_model.time;
        cell.contentField.userInteractionEnabled = NO;
    }
    else if (indexPath.section ==4) {
        cell.contentField.userInteractionEnabled = NO;
        cell.contentStr =[XDTimeManager timeWithString:_setInfoModel.bindTime];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        if (_teamArray.count==indexPath.row||_teamArray.count==0) {
            XDAddTeamViewController *vc = [[XDAddTeamViewController alloc] init];
            vc.model = _setInfoModel;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else{
            XDUserViewController *vc = [[XDUserViewController alloc] init];
            vc.isOnlyOne = NO;
            if (_teamArray.count==1) {
                vc.isOnlyOne = YES;
            }
            vc.userModel = _teamArray[indexPath.row];
            vc.model = _setInfoModel;
            vc.indexNum = _indexNum;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    [self.view endEditing:YES];
}
#pragma mark 请求设备成员列表
- (void)requestUserList{
    NSString *url =[NSString stringWithFormat:@"%@/device/user/list",APIHEADStr];
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] init];
    [dataDic setValue:_model.deviceId forKey:@"deviceId"];
    [[XDNetWork sharedInstance]postRequestWithUrl:url andParameters:dataDic success:^(NSDictionary *success) {
        if ([success[@"code"] intValue]==200) {
            [_teamArray removeAllObjects];
            NSDictionary *datdDic =success[@"data"];
            NSMutableArray *dataArray = datdDic[@"list"];
            if (dataArray.count==0||dataArray==nil) {
                return ;
            }
            for (int a=0; a<dataArray.count; a++) {
                NSDictionary * infoDic = dataArray[a];
                XDUserModel * model =[XDUserModel yy_modelWithJSON:infoDic];
                [_teamArray addObject:model];
            }
        }
        [_bgTablview reloadData];
    } failure:^(NSError *failure) {
        
    }];
}

#pragma mark 获取设备信息
- (void)requestInfoDataWithDeviceId:(NSString *)deviceId {
    NSString *url =[NSString stringWithFormat:@"%@/device/property",APIHEADStr];
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] init];
    [dataDic setValue:_model.deviceId forKey:@"deviceId"];
    [[XDNetWork sharedInstance]postRequestWithUrl:url andParameters:dataDic success:^(NSDictionary *success) {
        if ([success[@"code"] intValue]==200){
            _setInfoModel =[XDSetInfoDetailModel yy_modelWithDictionary:success[@"data"]];
        }
    } failure:^(NSError *failure) {
    }];
}

- (void)dealloc{
    
    NSLog(@"---dealloc---");
}

@end
