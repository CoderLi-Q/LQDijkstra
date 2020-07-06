//
//  ViewController.m
//  Dijkstra
//
//  Created by Schaffer on 2020/7/6.
//  Copyright © 2020 LQ. All rights reserved.
//

#import "ViewController.h"
#import "LQPathModel.h"
@interface ViewController ()
@property (nonatomic ,copy) NSString *startPoint;
@property (nonatomic , strong) NSArray *pathArray;
@property (nonatomic , strong) NSArray *allPoints;
@property (nonatomic , strong) NSArray <LQPathModel *>*allFirstPoint;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
    
    //准备数据,画线(后续提供画图能力)
    NSArray *arr = @[
    @[@"A",@"B",@"12"],
    @[@"A",@"G",@"14"],
    @[@"A",@"F",@"14"],
    @[@"B",@"C",@"10"],
    @[@"B",@"F",@"7"],
    @[@"G",@"F",@"14"],
    @[@"G",@"E",@"8"],
    @[@"F",@"C",@"6"],
    @[@"F",@"E",@"2"],
    @[@"C",@"D",@"3"],
    @[@"C",@"E",@"5"],
    @[@"E",@"D",@"4"]];
    
    //解析路径model：end，start，value
    NSMutableArray *pathArray = [NSMutableArray arrayWithCapacity:5];
    for (NSArray *path in arr) {
        LQPathModel *pathModel = [[LQPathModel alloc] init];
        for (int i = 0; i < path.count; i++) {
            switch (i) {
                case 0:
                    pathModel.startPoint = path[0];
                    break;
                case 1:
                    pathModel.endPoint = path[1];
                    break;
                case 2:
                    pathModel.value = [path[2] intValue];
                    break;
                    
                default:
                    break;
            }
        }
        [pathArray addObject:pathModel];
    }
    self.pathArray = pathArray;
    NSLog(@"原始数据%@--count = %ld",pathArray,pathArray.count);
   
    
    
    //算法实现
    
     //初始化所有顶点
    NSArray *points = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G"];
    self.allPoints = points;
     //初始化起点
        LQPathModel *pathStart = [[LQPathModel alloc] init];
        pathStart.startPoint = @"D";
        pathStart.endPoint = @"D";
        pathStart.value = 0;
        NSMutableArray *sArray = [NSMutableArray arrayWithObject:pathStart];
    NSLog(@"S数据 = %@, count = %ld",sArray,sArray.count);
    //初始化除起点外的顶点
      NSMutableArray *noStartPoints = [NSMutableArray arrayWithArray:@[@"A",@"B",@"C",@"E",@"F",@"G"]];
    
    
   NSMutableArray *uArray = [self getNewUArray:noStartPoints nextPoint:@"D" lastPoint:nil sArray:sArray];
    
    
    uArray = [NSMutableArray arrayWithCapacity:5];
    NSMutableArray *firstPoints = [NSMutableArray arrayWithCapacity:2];
    for (NSString *point in noStartPoints) {
        
        LQPathModel *pathStart = [[LQPathModel alloc] init];
        
        BOOL isHave = NO;
        for (LQPathModel *p in pathArray) {
            pathStart.startPoint = @"D";
            pathStart.endPoint = point;
            
            if ([p isPoint1:pathStart.startPoint point2:point]) {
                pathStart.value = p.value;
                isHave = YES;
                [firstPoints addObject:pathStart];
                break;
            }
            
        }
        
        if (!isHave) {
            pathStart.endPoint = point;
            pathStart.value = MAXFLOAT;
        }
        [uArray addObject:pathStart];
        
        
        
    }
    self.allFirstPoint = firstPoints;
    NSLog(@"U数据%@--count = %ld",uArray,uArray.count);
    
    
    NSString *endPoint = @"";
    while (![endPoint isEqualToString:@"A"]) {
        //找到U中最小value
           LQPathModel *mixValuepath = nil;
           for (LQPathModel *path in uArray) {
               if (mixValuepath == nil) {
                   mixValuepath = path;
               }else{
                   if (mixValuepath.value > path.value) {
                       mixValuepath = path;
                   }
               }
           }
           
           //将mixValuepath 加入到S数组
           [sArray addObject:mixValuepath];
        NSLog(@"mixValuepath = %@",mixValuepath);
        NSLog(@"sArray = %@",sArray);
        //将mixValuepath移除U数组
        [uArray removeObject:mixValuepath];
        NSLog(@"uArray = %@",uArray);
        //切换顶点
        
        NSString *nextPoint = mixValuepath.endPoint;
        endPoint = nextPoint;
        //更新U数组
    noStartPoints = [NSMutableArray arrayWithArray:noStartPoints];
    [noStartPoints removeObject:nextPoint];
        
    uArray = [self getNewUArray:noStartPoints nextPoint:nextPoint lastPoint:mixValuepath.startPoint sArray:sArray];
    NSLog(@"uArray = %@",uArray);
        NSLog(@"===========");
    }
    NSLog(@"sArray = %@",sArray);
    
}




-(NSMutableArray *)getNewUArray:(NSMutableArray *)otherPoints
                      nextPoint:(NSString *)nextPoint
                      lastPoint:(NSString *)lastPoint sArray:(NSMutableArray *)sArray{
    NSMutableArray *uArray = [NSMutableArray arrayWithCapacity:5];
    for (NSString *point in otherPoints) {
        
        LQPathModel *pathStart = [[LQPathModel alloc] init];
        
        BOOL isHave = NO;
        for (LQPathModel *p in self.pathArray) {
            pathStart.startPoint = nextPoint;
            pathStart.endPoint = point;
            
            if ([p isPoint1:nextPoint point2:point]) {
                
                
                if (lastPoint == nil) {//没有lastPoint
                    
                    pathStart.value = p.value;
                    isHave = YES;
                    break;
                }else{
                    if (![p isPoint1:lastPoint point2:point]) {//跟last
                        pathStart.value = p.value;
                        
                       
                        for (LQPathModel *model in sArray) {
                            if ([nextPoint isEqualToString:model.endPoint]) {
                                pathStart.value = p.value + model.value;
                                //如果point与@“D”
                                for (LQPathModel *pa in self.allFirstPoint) {
                                    if ([pa.endPoint isEqualToString:point]) {
                                        pathStart.value = pa.value;
                                    }
                                }
                                
                                
                            }
                        }
                        
                        isHave = YES;
                        break;
                    }
                }
            }
            
        }
        
        if (!isHave) {
            pathStart.endPoint = point;
            pathStart.value = MAXFLOAT;
        }
        [uArray addObject:pathStart];
        
        
        
    }
    return uArray;
}


@end
