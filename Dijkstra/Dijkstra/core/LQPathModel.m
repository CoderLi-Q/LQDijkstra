//
//  LQPathModel.m
//  Dijkstra
//
//  Created by Schaffer on 2020/7/6.
//  Copyright © 2020 LQ. All rights reserved.
//

#import "LQPathModel.h"

@implementation LQPathModel
-(void)encodeWithCoder:(NSCoder *)coder{
    [coder encodeObject:_startPoint forKey:@"startPoint"];
    [coder encodeObject:_endPoint forKey:@"endPoint"];
    [coder encodeFloat:_value forKey:@"value"];
    
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        _startPoint = [coder decodeObjectForKey:@"startPoint"];
        _endPoint = [coder decodeObjectForKey:@"endPoint"];
        _value = [coder decodeFloatForKey:@"value"];
        
    }
    return self;
}



-(NSString *)description{
    return [NSString stringWithFormat:@" %@ - %@ - %.f",_startPoint,_endPoint,_value];
}
-(void)removePath:(NSString *)path{
    if (path == nil) {
        return;
    }
    NSMutableArray *m_rray = [NSMutableArray arrayWithArray:self.paths];
    [m_rray removeObject:path];
    self.paths = m_rray;
}
-(void)addPaths:(NSArray *)paths{
    if (paths == nil || paths.count == 0) {
        return;
    }
    NSMutableArray *m_rray = [NSMutableArray arrayWithArray:self.paths];
    
    for (NSString *path in paths) {
        if (![m_rray containsObject:path]) {
            [m_rray addObject:path];
        }
    }
    
    
    
    self.paths = m_rray;
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
