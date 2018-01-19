//
//  XDElectronVFenceListVC.m
//  TrafficAPP
//
//  Created by xiao dou on 2017/8/9.
//  Copyright © 2017年 xiao dou. All rights reserved.
//
#import "XDElectronVFenceListVC.h"
#import "XDFenceTableViewCell.h"
#import "XDFenceTableViewTwoCell.h"
#import "XDCricleModel.h"
//#import "XDMessageViewController.h"
@interface XDElectronVFenceListVC ()
@end
@implementation XDElectronVFenceListVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.title = @"我的围栏";
    _bgTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    _bgTableView.delegate = self;
    _bgTableView.dataSource = self;
    _bgTableView.estimatedRowHeight = 0;
    _bgTableView.estimatedSectionHeaderHeight = 0;
    _bgTableView.estimatedSectionFooterHeight = 0;
    _bgTableView.backgroundColor =[UIColor colorWithHexString:@"#f0f0f0"];
    [self.view addSubview:_bgTableView];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    XDCricleModel *modelObject =[XDFenceManager sharedManager].allFenceDataArray[indexPath.row];
    if ([modelObject.shape isEqualToString:@"circle"]==YES) {
        return 80;
    }
    return 65;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [XDFenceManager sharedManager].allFenceDataArray.count;
}
#pragma mark - 初始化Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XDCricleModel *modelObject =[XDFenceManager sharedManager].allFenceDataArray[indexPath.row];
    if ([modelObject.shape isEqualToString:@"circle"]==YES) {
        XDFenceTableViewCell * rCell = [XDFenceTableViewCell cellWithTableView:tableView];
        [self configHotCell:rCell atIndexPath:indexPath];
        return rCell;
    }
   else{
       XDFenceTableViewTwoCell * rCell = [XDFenceTableViewTwoCell cellWithTableView:tableView];
       [self configmsgTwoCell:rCell atIndexPath:indexPath];
       return rCell;
   }
    return nil;
}
#pragma mark - 设置Cell内容
-(void)configHotCell:(XDFenceTableViewCell *)cell atIndexPath:(NSIndexPath*)indexPath
{
    XDCricleModel *modelObject =[XDFenceManager sharedManager].allFenceDataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.modelObject = modelObject;
}

#pragma mark - 设置Cell内容
-(void)configmsgTwoCell:(XDFenceTableViewTwoCell *)cell atIndexPath:(NSIndexPath*)indexPath{
    XDCricleModel *modelObject = [XDFenceManager sharedManager].allFenceDataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.modelObject = modelObject;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@" 删除 "handler:^(UITableViewRowAction *action,NSIndexPath *indexPath) {
        NSLog(@"解绑选定");
        [self removeFenceDataWithIndex:indexPath.row];
    }];
    
     XDCricleModel *modelObject = [XDFenceManager sharedManager].allFenceDataArray[indexPath.row];
    
    if ([modelObject.status isEqualToString:@"on"]==NO) {
        UITableViewRowAction *useFenceAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"启用围栏"handler:^(UITableViewRowAction *action,NSIndexPath *indexPath) {
            [self editFenceDataWoithIndexPath:indexPath andStatusStr:@"on"];
        }];
        useFenceAction.backgroundColor = [UIColor colorWithHexString:@"#4DB2FF"];
        return @[deleteRowAction,useFenceAction];
    }
    else{
        UITableViewRowAction *unUseFenceAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"关闭围栏"handler:^(UITableViewRowAction *action,NSIndexPath *indexPath) {
          [self editFenceDataWoithIndexPath:indexPath andStatusStr:@"off"];
        }];
        unUseFenceAction.backgroundColor = [UIColor colorWithHexString:@"#D8D8D8"];
        
        return @[deleteRowAction,unUseFenceAction];
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    XDCricleModel *resultObject =[AppDelegate appDelegate].allFenceArray[indexPath.row];
//    XDProtectViewController *vc =[[XDProtectViewController alloc] init];
//    vc.navigationItem.title = @"围栏详情";
//    vc.isCheck = YES;
//    vc.modelObject =resultObject;
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
}
/**
 移除围栏
 */
#pragma mark移除围栏
- (void)removeFenceDataWithIndex:(NSInteger )selectTag
{
   XDCricleModel *resultObject =[XDFenceManager sharedManager].allFenceDataArray[selectTag];
    NSString *url =[NSString stringWithFormat:@"%@/scope/remove",APIHEADStr];
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] init];
    [dataDic setValue:resultObject.scopeId forKey:@"scopeId"];
    [[XDNetWork sharedInstance]postRequestWithUrl:url andParameters:dataDic success:^(NSDictionary *success) {
          if ([success[@"code"] intValue]==200) {
              [self showHUDHintWithText:@"移除成功"];
              id fenceObj = [[XDFenceManager sharedManager].fenceShapeArray objectAtIndex:selectTag];
              [XDFenceManager sharedManager].deleteFenceShape = fenceObj;
              [[XDFenceManager sharedManager].allFenceDataArray removeObjectAtIndex:selectTag];
              [_bgTableView reloadData];
          }
        else{
            [self showHUDHintWithText:success[@"status"]];
        }
    } failure:^(NSError *failure) {
         [self showHUDHintWithText:@"请稍后再试"];
    }];
}
#pragma mark- 编辑围栏状态
- (void)editFenceDataWoithIndexPath:(NSIndexPath *)indexPath andStatusStr:(NSString *)statusStr{
    [_bgTableView endEditing: YES];
    XDCricleModel *modelObject =[XDFenceManager sharedManager].allFenceDataArray[indexPath.row];
    modelObject.status =statusStr;
    NSString *url =[NSString stringWithFormat:@"%@/scope/update",APIHEADStr];
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] init];
    [dataDic setValue:modelObject.scopeId forKey:@"scopeId"];
    [dataDic setValue:statusStr forKey:@"status"];
    [dataDic setValue:modelObject.scopeName forKey:@"scopeName"];
    [[XDNetWork sharedInstance]postRequestWithUrl:url andParameters:dataDic success:^(NSDictionary *success) {
        if ([success[@"code"] intValue]==200) {
          
            modelObject.status = dataDic[@"status"];
            modelObject.statusBool = !modelObject.statusBool;
            [[XDFenceManager sharedManager].allFenceDataArray replaceObjectAtIndex:indexPath.row withObject:modelObject];
            [[NSNotificationCenter defaultCenter] postNotificationName:XDChageFenceNotification object:[NSNumber numberWithInteger:indexPath.row]];
            [_bgTableView reloadData];
        }
    } failure:^(NSError *failure) {
    }];
}

- (void)dealloc{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
