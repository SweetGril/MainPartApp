//
//  XDFenceManager.h
//  XDTrafficPart01
//
//  Created by xiao dou on 2018/1/10.
//  Copyright © 2018年 xiao dou. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 围栏管理类方法
 */
@interface XDFenceManager : NSObject

/**
 所有的围栏信息
 */
@property (nonatomic,strong)NSMutableArray *allFenceDataArray;
@property (nonatomic,strong) NSMutableArray *fenceShapeArray;
+ (XDFenceManager *)sharedManager;
/**获取所有的设备 列表信息*/
- (NSMutableArray *)allFenceDataArray;
/**
 fenceArray 电子围栏的展示 数组
 [XDFenceManager sharedManager].allFenceArray 围栏原数据数组
 */
- (NSMutableArray *)fenceShapeArray;
- (void)postFenceDicSuccess:(void (^)(NSDictionary *success))successBlock
                    failure:(void (^)(NSError *failure))failureBlock;


@end

