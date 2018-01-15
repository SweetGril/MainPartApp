//
//  XDMonitoManager.h
//  XDTrafficPart02
//
//  Created by xiao dou on 2018/1/12.
//  Copyright © 2018年 xiao dou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XDEditFencePointAntion.h"
#import "XDCricleModel.h"
#import "XDCirlcle.h"
#import "XDMAPolygon.h"
@interface XDMonitoManager : NSObject

@property (nonatomic,strong)XDEditFencePointAntion *selectAnnotation;
@property (nonatomic,strong)XDCirlcle * circleShow;//作为点击展示的圆形围栏
@property (nonatomic,strong)XDMAPolygon * polyLineShow;//作为点击现实的多边形围栏
@property (nonatomic,strong)MAMapView *bgMapView;
+ (XDMonitoManager*)sharedInstance;
/**更新围栏数组中的某一个围栏 */
- (void)reloadFenceWithFenceModel:(XDCricleModel *)fenceModel andObj:(id)shape selectNun:(int)selectNum;
- (void)touchMapWithCoordinate:(CLLocationCoordinate2D)coordinate andShape:(id)shape andTouchType:(BOOL)touchStyle andEditPointAnntion:(XDEditFencePointAntion *)annotation andCirlcle:(XDCirlcle *)circleShow  andPolygon:(XDMAPolygon *)polyLineShow andBgMapView:(MAMapView *)bgMapView;
@end
