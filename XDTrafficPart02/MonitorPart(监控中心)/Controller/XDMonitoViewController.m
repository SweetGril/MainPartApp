//
//  XDMonitoViewController.m
//  XDTrafficPart01
//
//  Created by xiao dou on 2018/1/5.
//  Copyright © 2018年 xiao dou. All rights reserved.
//

#import "XDMonitoViewController.h"
#import "XDDeviceManager.h"
#import "XDMonitoManager.h"
/**监控中心*/
@interface XDMonitoViewController ()
@end
@implementation XDMonitoViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"监控中心";
    [[XDDeviceManager sharedManager] addObserver:self forKeyPath:@"changeDeviceTopic" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editFence:) name:XDChageFenceNotification object:nil];
      self.objectModel= nil;
}
#pragma mark 设备的长按事件
- (void)clickEditLongTouchModel:(EquipmentModel *)modelObj andAnnotation:(XDVehicleAnnotationView *)annotationView{
    [self hideMapSupportView];
    _equipmodel = modelObj;
    [self.bgMapView setZoomLevel:17 atPivot:self.view.center animated:NO];
    self.bgMapView.centerCoordinate = CLLocationCoordinate2DMake(_equipmodel.lat, _equipmodel.lon);
    
    self.selectPoint.hidden =NO;
    [self.editDeviceView removeFromSuperview];
    self.editDeviceView =nil;
    self.editDeviceView =[XDDeviceEditTipView shareTipViewWithFrame:CGRectMake(ScreenWidth/2-100, ScreenHeight/2-90, 200, 70)];
    WEAKSELF
    self.editDeviceView.setDeviceClick = ^{
         STRONGSELFFor(weakSelf)
        [strongSelf setDeviceInfoBlock];
    };
    self.editDeviceView.modelObject = modelObj;
    [self.view addSubview:_editDeviceView];
    self.editDeviceView.deviceName.placeholder= modelObj.deviceName;
    self.editDeviceView.speedLab.text =[NSString stringWithFormat:@"%.0f km/h",modelObj.speed];
    self.selectPoint =annotationView;
    self.selectPoint.calloutView.hidden = YES;
    self.selectPoint.tipImgViewIcon.hidden = YES;
    self.bgMapView.scrollEnabled = NO;
    self.bgMapView.centerCoordinate = CLLocationCoordinate2DMake(modelObj.lat, modelObj.lon);
}
#pragma mark 设备的单点事件
- (void)clickEditSingleTouchModel:(EquipmentModel *)modelObj andAnnotation:(XDVehicleAnnotationView *)annotationView{
    [self hideMapSupportView];
    _equipmodel = modelObj;
    self.bgMapView.centerCoordinate = CLLocationCoordinate2DMake(_equipmodel.lat, _equipmodel.lon);
    [self.bgMapView setZoomLevel:17 atPivot:self.view.center animated:NO];
    [self.bgMapView selectAnnotation:annotationView.annotation animated:YES];
}
#pragma mark 围栏的 单点 事件
- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate{
    [self hideMapSupportView];
    id selectShape = [XDClloctionManager isIncludePointAtCoordinate:coordinate andShapeLine:[XDFenceManager sharedManager].fenceShapeArray];
    if (selectShape!=nil) {
        [self touchMapWithCoordinate:coordinate andShape:selectShape andTouchType:NO];
    }
}
#pragma mark 围栏的 长按 事件
- (void)mapView:(MAMapView *)mapView didLongPressedAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    [self hideMapSupportView];
    id selectShape = [XDClloctionManager isIncludePointAtCoordinate:coordinate andShapeLine:[XDFenceManager sharedManager].fenceShapeArray];
    if (selectShape!=nil) {
        [self touchMapWithCoordinate:coordinate andShape:selectShape andTouchType:YES];
    }
    else{
        [self.bgMapView removeOverlay:_circleShow];
        [self.bgMapView removeOverlay:_polyLineShow];
        [self.bgMapView removeAnnotation:_annotation];
        _annotation =nil;
    }
}
/**
 touchStyle BOOL
 NO 单点围栏
 YES 为长按围栏
 */
#pragma mark 触碰围栏后的操作
- (void)touchMapWithCoordinate:(CLLocationCoordinate2D)coordinate andShape:(id)shape andTouchType:(BOOL)touchStyle{
    
    [[XDMonitoManager sharedInstance] touchMapWithCoordinate:coordinate andShape:shape andTouchType:touchStyle andEditPointAnntion:_annotation andCirlcle:_circleShow andPolygon:_polyLineShow andBgMapView:self.bgMapView];
    _annotation = [XDMonitoManager sharedInstance].selectAnnotation;
    _circleShow = [XDMonitoManager sharedInstance].circleShow;
    _polyLineShow = [XDMonitoManager sharedInstance].polyLineShow;
    self.bgMapView = [XDMonitoManager sharedInstance].bgMapView;
}
#pragma mark 设备后位置信息的实时更改 屏幕的中心位置可能实时修改
- (void)deviceMoveWithCLLocationCoordinate2D:(CLLocationCoordinate2D )coordinate andSpeedStr:(NSString *)speedStr andTopic:(NSString *)topic
{
    if ([_equipmodel.realTopic isEqualToString:topic]==YES) {
        self.bgMapView.centerCoordinate = coordinate;
        self.editDeviceView.speedLab.text =speedStr;
    }
}

#pragma mark 修改围栏状态信息的方法
-(void)editFence:(NSNotification *)notifiction{
    
    NSNumber * selectNumber = (NSNumber *)notifiction.object;
    int selectNum = [selectNumber intValue];
    XDCricleModel * fenceModel = [XDFenceManager sharedManager].allFenceDataArray[selectNum];
    id shape = [XDFenceManager sharedManager].fenceShapeArray [selectNum];
    [[XDMonitoManager sharedInstance]reloadFenceWithFenceModel:fenceModel andObj:shape selectNun:selectNum];
  
    
}
#pragma mark ----修改设备的名称
- (void)setDeviceInfoBlock{
    
    _selectPoint.calloutView.hidden = NO;
    _selectPoint.tipImgViewIcon.hidden = NO;
//    _selectPoint.calloutView.infoStr =[NSString stringWithFormat:@"%@%@",_editDeviceView.deviceName.text,_editDeviceView.speedLab.text];
//
    [_editDeviceView removeFromSuperview];
    _editDeviceView=nil;
 
    self.bgMapView.scrollEnabled = YES;
}
#pragma mark 隐藏界面中的 弹出部分View
- (void)hideMapSupportView{
    [self.bgMapView removeAnnotation:_annotation];
    [self.bgMapView removeOverlay:_circleShow];
    [self.bgMapView removeOverlay:_polyLineShow];
    _annotation =nil;
    self.selectPoint.calloutView.hidden = NO;
    self.selectPoint.tipImgViewIcon.hidden = NO;
    self.selectPoint = nil;
    _equipmodel =nil;
    self.bgMapView.scrollEnabled = YES;
    [_editDeviceView removeFromSuperview];
}

#pragma mark 从设备列表跳转进入的设备点击事件
- (void)selectAnnotationViewWithModel:(EquipmentModel *)model{
    NSArray *allPoint = [self.bgMapView annotations];
    for (int a =0; a<allPoint.count; a++) {
        MAPointAnnotation *annotation = allPoint[a];
        if ([annotation isKindOfClass:[XDMAPointAnnotation class]]==YES) {
            XDMAPointAnnotation *objanntation = (XDMAPointAnnotation *)annotation;
            if ([objanntation.model.realTopic isEqualToString:model.realTopic]) {
                _equipmodel = model;
                self.bgMapView.centerCoordinate= CLLocationCoordinate2DMake(model.lat, model.lon);
                [self.bgMapView selectAnnotation:annotation animated:YES];
                [self.bgMapView setZoomLevel:17 atPivot:self.view.center animated:NO];
                return;
            }
        }
    }
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id>*)change context:(void *)context{
    if ([keyPath isEqualToString:@"changeDeviceTopic"]==YES) {
        NSArray *allPoint = [self.bgMapView annotations];
        for (int a =0; a<allPoint.count; a++) {
            MAPointAnnotation *annotation = allPoint[a];
            if ([annotation isKindOfClass:[XDMAPointAnnotation class]]==YES) {
                XDMAPointAnnotation *objanntation = (XDMAPointAnnotation *)annotation;
                if ([objanntation.model.realTopic isEqualToString:[XDDeviceManager sharedManager].changeDeviceTopic]) {
                    [self.bgMapView removeAnnotation:annotation];
                    [[XDDeviceManager sharedManager].allDeviceAnnotationArray removeObject:objanntation];
                    EquipmentModel *model = [[XDDeviceManager sharedManager].allDeviceDictionary objectForKey:objanntation.model.realTopic];
                    CLLocationCoordinate2D point = model.location2D;
                    XDMAPointAnnotation *annotation = [[XDMAPointAnnotation alloc] init];
                    annotation.coordinate = point;
                    annotation.model = model;
                    [self.bgMapView addAnnotation:annotation];
                    [[XDDeviceManager sharedManager].allDeviceAnnotationArray addObject:annotation];
                    if ([_equipmodel.realTopic isEqualToString:objanntation.model.realTopic]==YES) {
                        [self.bgMapView selectAnnotation:annotation animated:YES];
                    }
                    
                }
            }
        }
        
    }
}
- (void)dealloc{
     NSLog(@"---XDMonitoViewController---dealloc--");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:XDChageFenceNotification object:nil];
    [[XDDeviceManager sharedManager] removeObserver:self forKeyPath:@"changeDeviceTopic" context:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
