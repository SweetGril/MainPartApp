//
//  XDFenceInfoView.h
//  TrafficAPP
//
//  Created by xiao dou on 2017/9/21.
//  Copyright © 2017年 xiao dou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XDFenceInfoView : UIView
@property (strong, nonatomic) IBOutlet UILabel *fenceNameLab;
@property (strong, nonatomic) IBOutlet UIImageView *bgDrawView;
@property (strong, nonatomic) IBOutlet UILabel *statusLab;
+(instancetype)shareFenceViewViewWithFrame:(CGRect)objFrame;
@end
