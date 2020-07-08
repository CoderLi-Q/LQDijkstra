//
//  LQDijkstaTool.h
//  Dijkstra
//
//  Created by Schaffer on 2020/7/6.
//  Copyright © 2020 LQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQPathModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LQDijkstraTool : NSObject
@property (nonatomic ,copy) NSString *startPoint;
@property (nonatomic ,copy) NSString *endPoint;

@property (nonatomic , strong) NSArray <LQPathModel *>*linesArray;

-(CGFloat)getDijkstra;
@end

NS_ASSUME_NONNULL_END
