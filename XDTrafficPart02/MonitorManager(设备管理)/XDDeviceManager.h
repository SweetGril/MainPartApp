//
//  XDDeviceManager.h
//  XDTrafficPart01
//
//  Created by xiao dou on 2018/1/8.
//  Copyright © 2018年 xiao dou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XDNetWork.h"
#import "EquipmentModel.h"
/**
 设备管理类方法
 */
@interface XDDeviceManager : NSObject
/**
 所有的设备字典
 topic 作为键
 相关信息作为值
 */
@property (nonatomic,strong)NSMutableDictionary *allDeviceDictionary;
/**
 由于 allDeviceDictionary 是个无序的，不能按照原始的数据 进行排列，所以用key数组来进行顺序排列
 */
@property (nonatomic,strong)NSMutableArray *allDeviceKeyArray;
/**所有的设备的annotation 数组*/
@property (nonatomic,strong)NSMutableArray *allDeviceAnnotationArray;
/**发生地址改变的deviceTopic */
@property (nonatomic,strong)NSString *changePlaceTopic;
/**发生设备信息修改 deviceTopic */
@property (nonatomic,strong)NSString *changeDeviceTopic;

+ (XDDeviceManager *)sharedManager;
/**获取所有的设备 列表信息*/
- (NSMutableDictionary *)getDeviceDictionary;
/**获取所有的设备 对应的key数组*/
- (NSMutableArray *)getDeviceKeyArray;
/**获取 所有的设备的annotation 数组*/
- (NSMutableArray *)allDeviceAnnotationArray;

/**通过索引位置 获取对应的EquipmentModel */
- (EquipmentModel *)getModelWithIndex:(NSInteger )index;
- (void)postDeviceListsuccess:(void (^)(NSDictionary *success))successBlock
                      failure:(void (^)(NSError *failure))failureBlock;


@end

