//
//  LQDataCache.h
//  Dijkstra
//
//  Created by Schaffer on 2020/7/8.
//  Copyright © 2020 LQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LQPointModel.h"
typedef void(^LQHistoryBlock)(NSArray *array);

NS_ASSUME_NONNULL_BEGIN

@interface LQDataCache : NSObject
+(void)getHistoryData:(LQHistoryBlock)historyblock;
+(void)addHistory:(NSArray *)pointModels;
@end

NS_ASSUME_NONNULL_END
