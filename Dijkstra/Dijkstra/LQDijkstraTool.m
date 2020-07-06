//
//  LQDijkstaTool.m
//  Dijkstra
//
//  Created by Schaffer on 2020/7/6.
//  Copyright © 2020 LQ. All rights reserved.
//

#import "LQDijkstraTool.h"

@interface LQDijkstraTool ()
@property (nonatomic , strong) NSArray *pathArray;
@end

@implementation LQDijkstraTool

-(CGFloat)getDijkstra{
    

    NSArray *arr = self.linesArray;
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

       //初始化起点
          LQPathModel *pathStart = [[LQPathModel alloc] init];
          pathStart.startPoint = @"D";
          pathStart.endPoint = @"D";
          pathStart.value = 0;
          NSMutableArray <LQPathModel *>*sArray = [NSMutableArray arrayWithObject:pathStart];
      NSLog(@"S数据 = %@, count = %ld",sArray,sArray.count);
      //初始化除起点外的顶点
        NSMutableArray *noStartPoints = [NSMutableArray arrayWithArray:@[@"A",@"B",@"C",@"E",@"F",@"G"]];
      
    

       
      NSMutableArray *uArray = [NSMutableArray arrayWithCapacity:2];
      NSString *endPoint = @"D";
        NSString *lastPoint = @"";
      while (![endPoint isEqualToString:@"A"]) {
          LQPathModel *mixValuepath = nil;
          //切换顶点
          NSString * currentPoint = endPoint;
          
          
          if(uArray.count != 0){
          //找到U中最小value
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
          
          //更新U数组
      noStartPoints = [NSMutableArray arrayWithArray:noStartPoints];
              currentPoint = mixValuepath.endPoint;
              [noStartPoints removeObject:currentPoint];
      }
          uArray = [self lq_getNewUArray:noStartPoints nextPoint:currentPoint lastPoint:lastPoint sArray:sArray];
      NSLog(@"newUArray = %@",uArray);
          NSLog(@"===========");
          
          endPoint = currentPoint;
          lastPoint = currentPoint;
          
      }
      NSLog(@"sArray = %@",sArray);
    return sArray.lastObject.value;
}


//计算新的U数组
-(NSMutableArray *)lq_getNewUArray:(NSMutableArray *)otherPoints
                      nextPoint:(NSString *)nextPoint
                      lastPoint:(NSString *)lastPoint
                         sArray:(NSMutableArray *)sArray
                         {
    NSMutableArray *uArray = [NSMutableArray arrayWithCapacity:5];
    for (NSString *point in otherPoints) {
        
        LQPathModel *pathStart = [[LQPathModel alloc] init];
        
        for (LQPathModel *model in sArray) {
            LQPathModel *contaionPath = [self isContainLineWithP1:point p2:model.endPoint];
            if (contaionPath) {//当前点与之前的结算点直接链接，value可计算
                if(pathStart.value == 0 || pathStart.value > contaionPath.value + model.value){
                pathStart.startPoint = @"D";
                pathStart.endPoint = point;
                pathStart.value = contaionPath.value + model.value;
                }
                
            }else{//value不可计算

            }
            
            
        }
        
        if (pathStart.startPoint == nil) {
            pathStart.startPoint = @"D";
            pathStart.endPoint = point;
            pathStart.value = MAXFLOAT;
        }
        
        [uArray addObject:pathStart];
    }
    return uArray;
}


-(LQPathModel *)isContainLineWithP1:(NSString *)p1 p2:(NSString *)p2{
    for (LQPathModel *path in self.pathArray) {
        if ([path isPoint1:p1 point2:p2]) {
            return path;
            
        }
    }
    return nil;
}

@end
