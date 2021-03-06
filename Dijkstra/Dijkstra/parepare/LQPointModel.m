//
//  LQPointModel.m
//  Dijkstra
//
//  Created by Schaffer on 2020/7/7.
//  Copyright © 2020 LQ. All rights reserved.
//

#import "LQPointModel.h"

@implementation LQPointModel
-(NSString *)description{
    return [NSString stringWithFormat:@"start = %@,end = %@,view1 = %p, view2 = %p",_startPointValue,_endPointValue,&_startView,&_endView];
}

-(NSString *)containView:(UIView *)view{
    
    if ([self.startView isEqual:view]) {
        return @"startPointValue";
    }else if ([self.endView isEqual:view]){
        return @"endPointValue";
    }
    
    return nil;
}
@end
