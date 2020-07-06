//
//  LQPathModel.m
//  Dijkstra
//
//  Created by Schaffer on 2020/7/6.
//  Copyright © 2020 LQ. All rights reserved.
//

#import "LQPathModel.h"

@implementation LQPathModel
-(NSString *)description{
    return [NSString stringWithFormat:@"startPoint = %@,endPoint = %@,value=%.f",_startPoint,_endPoint,_value];
}
@end
