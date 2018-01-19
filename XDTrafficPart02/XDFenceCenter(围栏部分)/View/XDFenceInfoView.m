//
//  XDFenceInfoView.m
//  TrafficAPP
//
//  Created by xiao dou on 2017/9/21.
//  Copyright © 2017年 xiao dou. All rights reserved.
//

#import "XDFenceInfoView.h"

@implementation XDFenceInfoView

+(instancetype)shareFenceViewViewWithFrame:(CGRect)objFrame{
    XDFenceInfoView * drawMenuView =  [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
    drawMenuView.frame = objFrame;
    drawMenuView.bgDrawView.clipsToBounds = YES;
    drawMenuView.bgDrawView.layer.cornerRadius = 6;
    return drawMenuView;
}
@end
