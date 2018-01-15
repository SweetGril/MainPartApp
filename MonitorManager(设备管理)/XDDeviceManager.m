//
//  XDDeviceManager.m
//  XDTrafficPart01
//
//  Created by xiao dou on 2018/1/8.
//  Copyright © 2018年 xiao dou. All rights reserved.
//

#import "XDDeviceManager.h"

/**
 设备管理类方法
 */
static XDDeviceManager *_deviceManager;
@implementation XDDeviceManager

+ (XDDeviceManager *)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _deviceManager = [[XDDeviceManager alloc] init];
    });
    return _deviceManager;
}
- (void)postDeviceListsuccess:(void (^)(NSDictionary *success))successBlock
                      failure:(void (^)(NSError *failure))failureBlock{
    NSString *url = APIHEADStr(@"/device/list");
    if (_allDeviceKeyArray.count!=0) {
        successBlock(nil);
    }
    else{
        _allDeviceDictionary = [[NSMutableDictionary alloc] init];
        _allDeviceKeyArray = [[NSMutableArray alloc] init];
        
        [XDDeviceManager sharedManager].changePlaceTopic = @"topic";
        [[XDNetWork sharedInstance]postRequestWithUrl:url andParameters:nil success:^(NSDictionary *success) {
            NSDictionary *listDic =success[@"data"];
            NSArray *listDeviceArray =listDic[@"list"];
            NSMutableDictionary *topicDic =[[NSMutableDictionary alloc] init];
            NSMutableArray *topicArray = [[NSMutableArray alloc] init];
            for (int a=0; a<listDeviceArray.count; a++){
                EquipmentModel *model =[EquipmentModel yy_modelWithJSON:listDeviceArray[a]];
                model.location2D = CLLocationCoordinate2DMake(model.lat, model.lon);
                model.time= [XDTimeManager timeWithMoreString:model.time];
                [topicDic setValue:model.realTopic forKey:model.realTopic];
                [topicArray addObject:model.realTopic];
                [_allDeviceDictionary setObject:model forKey:model.realTopic];
                [_allDeviceKeyArray addObject:model.realTopic];
                [[XDClloctionManager sharedManager]searchReGeocodeWithCoordinate:CLLocationCoordinate2DMake(model.lat,model.lon) withTopic:model.realTopic];
                [XDClloctionManager sharedManager].addressBlock = ^(NSString *addressStr, NSString *topic) {
                    NSLog(@"-1.-----place===%@",addressStr);
                    EquipmentModel *modelObj = [[XDDeviceManager sharedManager].allDeviceDictionary objectForKey:topic];
                    modelObj.placeStr =addressStr;
                    [_allDeviceDictionary setValue:modelObj forKey:topic];
                    [XDDeviceManager sharedManager].changePlaceTopic = topic;
                };
            }
            [[XDClientManager shareInstance].mqttSession subscribeToTopics:topicDic];
            successBlock(nil);
        } failure:^(NSError *failure) {
            failureBlock(nil);
        }];
    }
}

- (NSMutableDictionary *)getDeviceDictionary{
    return _allDeviceDictionary;
}
- (NSMutableArray *)getDeviceKeyArray{
    return _allDeviceKeyArray;
}
/**获取 所有的设备的annotation 数组*/
- (NSMutableArray *)allDeviceAnnotationArray{
    if (_allDeviceAnnotationArray==nil) {
        _allDeviceAnnotationArray = [[NSMutableArray alloc] init];
    }
    return _allDeviceAnnotationArray;
}

/**通过索引位置 获取对应的EquipmentModel */
- (EquipmentModel *)getModelWithIndex:(NSInteger )index{
    NSString *keyStr = _allDeviceKeyArray[index];
    EquipmentModel *modelObject = [XDDeviceManager sharedManager].allDeviceDictionary[keyStr];
    return modelObject;
}
@end

