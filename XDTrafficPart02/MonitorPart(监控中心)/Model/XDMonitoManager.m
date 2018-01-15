//
//  XDMonitoManager.m
//  XDTrafficPart02
//
//  Created by xiao dou on 2018/1/12.
//  Copyright © 2018年 xiao dou. All rights reserved.
//

#import "XDMonitoManager.h"
static XDMonitoManager *_manager;
@implementation XDMonitoManager
+ (XDMonitoManager*)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[XDMonitoManager alloc] init];
    });
    return _manager;
}
- (void)touchMapWithCoordinate:(CLLocationCoordinate2D)coordinate andShape:(id)shape andTouchType:(BOOL)touchStyle andEditPointAnntion:(XDEditFencePointAntion *)annotation andCirlcle:(XDCirlcle *)circleShow  andPolygon:(XDMAPolygon *)polyLineShow andBgMapView:(MAMapView *)bgMapView{
    annotation = [[XDEditFencePointAntion alloc] init];
    if ([shape isKindOfClass:[XDCirlcle class]] ) {
        XDCirlcle *circleobj = (XDCirlcle *)shape;
//        bgMapView.visibleMapRect = circleobj.boundingMapRect;
//        float zoomlevel= bgMapView.zoomLevel-1;
//        [bgMapView setZoomLevel:zoomlevel];
        
        circleShow = [XDCirlcle circleWithCenterCoordinate:circleobj.coordinate radius:circleobj.radius];
        circleShow.status =circleobj.status;
        circleShow.colorsStatus = YES;
        circleShow.indexNum =circleobj.indexNum;
        annotation.indexNum =circleobj.indexNum;
        annotation.titleStr =circleobj.fenceName;
        [bgMapView addOverlay:circleShow];
    }
    else{
        XDMAPolygon *polyline = (XDMAPolygon *)shape;
//        MAMapRect bounding = MAMapRectMake(polyline.boundingMapRect.origin.x, polyline.boundingMapRect.origin.y, polyline.boundingMapRect.size.width+400, polyline.boundingMapRect.size.height+400);
//        bgMapView.visibleMapRect = bounding;
//        float zoomlevel= bgMapView.zoomLevel-1;
//        [bgMapView setZoomLevel:zoomlevel];
        
        polyline.isColorStatus = YES;
        [bgMapView addOverlay:polyline];
        polyLineShow = [XDMAPolygon polygonWithCoordinates:polyline.polyLine count:polyline.pointCount];
        polyLineShow.status =polyline.status;
        polyLineShow.isColorStatus = YES;
        polyLineShow.fenceindexNum = polyline.fenceindexNum;
        annotation.titleStr =polyline.fenceName;
        annotation.indexNum =polyline.fenceindexNum;
        [bgMapView addOverlay:polyLineShow];
    }
    annotation.coordinate = coordinate;
    annotation.fenceStyle =touchStyle;
    [bgMapView addAnnotation:annotation];
    [bgMapView setCenterCoordinate:coordinate animated:NO];

    [XDMonitoManager sharedInstance].circleShow =circleShow;
    [XDMonitoManager sharedInstance].polyLineShow =polyLineShow;
    [XDMonitoManager sharedInstance].selectAnnotation =annotation;
    [XDMonitoManager sharedInstance].bgMapView = bgMapView;
}
/**更新围栏数组中的某一个围栏 */
- (void)reloadFenceWithFenceModel:(XDCricleModel *)fenceModel andObj:(id)shape selectNun:(int)selectNum{
    
    if ([shape isKindOfClass:[XDCirlcle class]] ) {
        XDCirlcle *circle = (XDCirlcle *)shape;
        circle.title = fenceModel.scopeName;
        
        if ([fenceModel.status isEqualToString:@"on"]==YES) {
            circle.status =@"on";
        }
        else{
            circle.status =@"off";
        }
        circle.fenceName =fenceModel.scopeName;
        MACircleRenderer *circleRender = (MACircleRenderer *)[self.bgMapView rendererForOverlay:circle];
        MACircleRenderer *circleRenderer2 = (MACircleRenderer *)[self.bgMapView rendererForOverlay:_circleShow];
        if ([fenceModel.status isEqualToString:@"off"]==YES) {
            circleRender.fillColor = [UIColor clearColor];
            circleRender.strokeColor = [UIColor colorWithHexString:@"c0c0c0" withAlpha:1];
            circleRenderer2.fillColor = [UIColor colorWithHexString:@"c0c0c0" withAlpha:0.5];
            circleRenderer2.strokeColor = [UIColor colorWithHexString:@"c0c0c0" withAlpha:1];
        }
        else{
            circleRender.fillColor = [UIColor clearColor];
            circleRender.strokeColor = [UIColor colorWithHexString:@"bf0000" withAlpha:1];
            circleRenderer2.fillColor = [UIColor colorWithHexString:@"FFA0A0" withAlpha:0.5];
            circleRenderer2.strokeColor = [UIColor colorWithHexString:@"bf0000" withAlpha:1];
        }
        [circleRender setNeedsUpdate];
        [circleRenderer2 setNeedsUpdate];
        [[XDFenceManager sharedManager].fenceShapeArray replaceObjectAtIndex:selectNum withObject:circle];
        
    }
    else{
        XDMAPolygon *polyline = (XDMAPolygon *)shape;
        polyline.status =fenceModel.status;
        polyline.fenceName =fenceModel.scopeName;
        MAPolygonRenderer *polylineRenderer = (MAPolygonRenderer *)[self.bgMapView rendererForOverlay:polyline];
        MAPolygonRenderer *polylineRenderer2 =(MAPolygonRenderer *)[self.bgMapView rendererForOverlay:_polyLineShow];
        if ([fenceModel.status isEqualToString:@"off"]==YES) {
            polylineRenderer.fillColor = [UIColor clearColor];
            polylineRenderer.strokeColor = [UIColor colorWithHexString:@"c0c0c0" withAlpha:1];
            polylineRenderer2.fillColor = [UIColor colorWithHexString:@"c0c0c0" withAlpha:0.5];
            polylineRenderer2.strokeColor = [UIColor colorWithHexString:@"c0c0c0" withAlpha:1];
        }
        else{
            polylineRenderer.fillColor = [UIColor clearColor];
            polylineRenderer.strokeColor = [UIColor colorWithHexString:@"bf0000" withAlpha:1];
            polylineRenderer2.fillColor = [UIColor colorWithHexString:@"FFA0A0" withAlpha:0.5];
            polylineRenderer2.strokeColor = [UIColor colorWithHexString:@"bf0000" withAlpha:1];
        }
        [polylineRenderer setNeedsUpdate];
        [polylineRenderer2 setNeedsUpdate];
        [[XDFenceManager sharedManager].fenceShapeArray replaceObjectAtIndex:selectNum withObject:polyline];
       
    }
    
}

@end
