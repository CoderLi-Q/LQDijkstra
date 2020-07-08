//
//  LQDataCache.m
//  Dijkstra
//
//  Created by Schaffer on 2020/7/8.
//  Copyright © 2020 LQ. All rights reserved.
//

#import "LQDataCache.h"

@interface LQDataCacheModel : NSObject <NSCoding>
@property (nonatomic , strong) NSArray *points;
@end

@implementation LQDataCacheModel

-(void)encodeWithCoder:(NSCoder *)coder{
    [coder encodeObject:_points forKey:@"points"];
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        _points = [coder decodeObjectForKey:@"point"];
    }
    return self;
}

@end

@implementation LQDataCache
+(void)addHistory:(NSArray *)pointModels{
    
    LQDataCacheModel *mode = [[LQDataCacheModel alloc] init];
    mode.points = pointModels;
    
    
    if (@available(iOS 12.0, *)) {
        NSError *error = nil;
       NSData *data = [NSKeyedArchiver archivedDataWithRootObject:mode requiringSecureCoding:NO error:&error];
        [data writeToFile:self.path atomically:YES];
    } else {
        
        [NSKeyedArchiver archiveRootObject:mode toFile:self.path];
    }
}

+(void)getHistoryData:(LQHistoryBlock)historyblock{
    LQDataCacheModel *mode = [NSKeyedUnarchiver unarchiveObjectWithFile:self.path];
    NSLog(@"%@--",mode);
}

+ (NSString *)path

{

NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);

NSString *documentDir = [paths objectAtIndex:0];

NSString *dstPath = [documentDir stringByAppendingPathComponent:@"user.data"];

return dstPath;

}

@end
