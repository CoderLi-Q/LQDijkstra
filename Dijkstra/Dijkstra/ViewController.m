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
    
    NSLog(@"原始数据%@--count = %ld",pathArray,pathArray.count);
   
    
    
    //算法实现
    
     //初始化所有顶点
    NSArray *points = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G"];
    
     //初始化起点
        LQPathModel *pathStart = [[LQPathModel alloc] init];
        pathStart.startPoint = @"D";
        pathStart.endPoint = @"D";
        pathStart.value = 0;
        NSMutableArray *sArray = [NSMutableArray arrayWithObject:pathStart];
    NSLog(@"S数据 = %@, count = %ld",sArray,sArray.count);
    //初始化除起点外的顶点
      NSArray *noStartPoints = @[@"A",@"B",@"C",@"E",@"F",@"G"];
    
    NSMutableArray *uArray = [NSMutableArray arrayWithCapacity:5];
    
    for (NSString *point in noStartPoints) {
        
        LQPathModel *pathStart = [[LQPathModel alloc] init];
        
        BOOL isHave = NO;
        for (LQPathModel *p in pathArray) {
            pathStart.startPoint = @"D";
            pathStart.endPoint = point;
            if ([p.startPoint isEqualToString:pathStart.startPoint] &&
                [p.endPoint isEqualToString:point]) {
                pathStart.value = p.value;
                isHave = YES;
                break;
            }else if ([p.endPoint isEqualToString:pathStart.startPoint]  &&
                      [p.startPoint isEqualToString:point]){
                pathStart.value = p.value;
                isHave = YES;
                break;
            }
            
        }
        
        if (!isHave) {
            pathStart.endPoint = point;
            pathStart.value = MAXFLOAT;
        }
        [uArray addObject:pathStart];
        
        
        
    }
    NSLog(@"U数据%@--count = %ld",uArray,uArray.count);
    
    
    
//    while (uArray>0) {
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
        //切换顶点
        
//    }
   
    
}


@end
