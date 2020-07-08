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
@property (nonatomic ,assign) float value;
@property (nonatomic , strong) NSArray *paths;//暂时没有实现

-(void)addPaths:(NSArray *)paths;
-(void)removePath:(NSString *)path;
-(BOOL)isPoint1:(NSString *)point1 point2:(NSString *)point2;
@end

NS_ASSUME_NONNULL_END
