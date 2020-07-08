//
//  LQDataView.h
//  Dijkstra
//
//  Created by Schaffer on 2020/7/6.
//  Copyright © 2020 LQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQPathModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LQDataView : UIView

@property (nonatomic , strong) NSArray <LQPathModel *> *pathDatas;

@property (nonatomic ,assign) NSInteger number;
@end

NS_ASSUME_NONNULL_END
