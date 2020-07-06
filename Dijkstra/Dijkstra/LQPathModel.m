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


-(BOOL)isPoint1:(NSString *)point1 point2:(NSString *)point2{
    BOOL isHave = NO;
    if ([self.startPoint isEqualToString:point1] &&
        [self.endPoint isEqualToString:point2]) {
        
        isHave = YES;
        
    }else if ([self.endPoint isEqualToString:point1]  &&
              [self.startPoint isEqualToString:point2]){
        isHave = YES;
        
    }
    return isHave;
    
}
@end
