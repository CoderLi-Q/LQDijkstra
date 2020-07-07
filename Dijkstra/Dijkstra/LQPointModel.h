//
//  LQPointModel.h
//  Dijkstra
//
//  Created by Schaffer on 2020/7/7.
//  Copyright © 2020 LQ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



@interface LQPointModel : NSObject
@property (nonatomic ,strong) NSValue *startPointValue;
@property (nonatomic ,strong) NSValue *endPointValue;
@property (nonatomic , strong) UIView *startView;
@property (nonatomic , strong) UIView *endView;
-(NSString *)containView:(UIView *)view;



@end

NS_ASSUME_NONNULL_END
