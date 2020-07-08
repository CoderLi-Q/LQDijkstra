//
//  LQDataCache.m
//  Dijkstra
//
//  Created by Schaffer on 2020/7/8.
//  Copyright © 2020 LQ. All rights reserved.
//

#import "LQDataCache.h"



@implementation LQDataCacheModel

-(void)encodeWithCoder:(NSCoder *)coder{
    [coder encodeObject:_points forKey:@"points"];
    [coder encodeObject:_name forKey:@"name"];
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        _points = [coder decodeObjectForKey:@"points"];
        _name = [coder decodeObjectForKey:@"name"];
    }
    return self;
}

@end


@implementation LQDataCache

static NSArray *_allHistory = nil;
+(void)load{
    [self updateHistoryData];
}

+(void)addHistory:(NSArray *)pointModels{
    
    LQDataCacheModel *mode = [[LQDataCacheModel alloc] init];
    mode.points = pointModels;
    
    NSString *string = [NSString stringWithFormat:@"%.f.data",NSDate.date.timeIntervalSince1970];
    mode.name = string;
    NSError *error = nil;
    if (@available(iOS 12.0, *)) {
        
       NSData *data = [NSKeyedArchiver archivedDataWithRootObject:mode requiringSecureCoding:NO error:&error];
        [data writeToFile:[self.path stringByAppendingPathComponent:string] atomically:YES];
    } else {
        
        [NSKeyedArchiver archiveRootObject:mode toFile:[self.path stringByAppendingPathComponent:string]];
    }
    
    
    [self updateHistoryData];
    
}


+(void)updateHistoryData{
    
    NSString *path = self.path;
    
    NSFileManager *fileM = [NSFileManager defaultManager];
    
    NSError *error = nil;
    NSArray <NSString *>*pathArray = [fileM contentsOfDirectoryAtPath:path error:&error];
    
    NSMutableArray *m_array = [NSMutableArray arrayWithCapacity:2];
    
    for (NSString *p in pathArray) {
        LQDataCacheModel *mode = [NSKeyedUnarchiver unarchiveObjectWithFile:[self.path stringByAppendingPathComponent:p]];
        NSLog(@"%@--name = %@",mode.points,mode.name);
        if (mode != nil) {
            
            [m_array addObject:mode];
        }else{
            NSLog(@"没有找到呢---nil");
        }
    }

       _allHistory = [NSArray arrayWithArray:m_array];
}

+(void)getHistoryData:(LQHistoryBlock)historyblock{
    if (historyblock) {
        historyblock(_allHistory);
    }
    
    
    
}
+(void)deleteHistoryData:(LQDataCacheModel *)model{
    NSMutableArray *m_array = [NSMutableArray arrayWithArray:_allHistory];
    [m_array removeObject:model];
    _allHistory = [NSArray arrayWithArray:m_array];
    
    NSFileManager *fileM = [NSFileManager defaultManager];
    [fileM removeItemAtPath:[self.path stringByAppendingPathComponent:model.name] error:nil];
}


+ (NSString *)path

{

NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);

NSString *documentDir = [paths objectAtIndex:0];

//NSString *dstPath = [documentDir stringByAppendingPathComponent:@"user.data"];

return documentDir;

}


@end
