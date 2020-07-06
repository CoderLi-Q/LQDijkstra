//
//  LQPathModel.h
//  Dijkstra
//
//  Created by Schaffer on 2020/7/6.
//  Copyright © 2020 LQ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LQPathModel : NSObject
@property (nonatomic ,copy) NSString *startPoint;
@property (nonatomic ,copy) NSString *endPoint;
@property (nonatomic ,assign) float value ;
@end

NS_ASSUME_NONNULL_END
