//
//  XDMonitoManager.h
//  XDTrafficPart02
//
//  Created by xiao dou on 2018/1/12.
//  Copyright © 2018年 xiao dou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XDEditFencePointAntion.h"
#import "EquipmentModel.h"
#import "XDCricleModel.h"
#import "XDCirlcle.h"
#import "XDMAPolygon.h"
@interface XDMonitoManager : NSObject

@property (nonatomic,strong)XDEditFencePointAntion *selectAnnotation;
@property (nonatomic,strong)XDCirlcle * circleShow;//作为点击展示的圆形围栏
@property (nonatomic,strong)XDMAPolygon * polyLineShow;//作为点击现实的多边形围栏
@property (nonatomic,strong)MAMapView *bgMapView;
+ (XDMonitoManager*)sharedInstance;
- (void)touchMapWithCoordinate:(CLLocationCoordinate2D)coordinate andShape:(id)shape andTouchType:(BOOL)touchStyle andEditPointAnntion:(XDEditFencePointAntion *)annotation andCirlcle:(XDCirlcle *)circleShow  andShowPolygon:(XDMAPolygon *)polyLineShow andBgMapView:(MAMapView *)bgMapView;

/**设备的 类型 名称 发生修改*/
- (void)reloadeDeviceofObject:(id)object change:(NSDictionary<NSString *,id>*)change context:(void *)context andSelectDeviceModel:(EquipmentModel *)equipmodel;
/**设备的 类型 名称 发生修改*/
- (void)deleteDeviceFromMap;

/**更新围栏数组中的某一个围栏*/
- (void)reloadSingleWithFenceModel:(XDCricleModel *)fenceModel andObj:(id)shape selectNun:(int)selectNum;
/**更新围栏数组中的某一个围栏 选中 状态下的*/
- (void)reloadFenceWithFenceModel:(XDCricleModel *)fenceModel andObj:(id)shape selectNun:(int)selectNum;
/**删除 某一个围栏 */
- (void)deleteFenceWithFenceObj:(id)shape;

+ (void)clearManager;
@end
