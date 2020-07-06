//
//  LQResultViewController.m
//  Dijkstra
//
//  Created by Schaffer on 2020/7/6.
//  Copyright © 2020 LQ. All rights reserved.
//

#import "LQResultViewController.h"
#import "LQDijkstraTool.h"
@interface LQResultViewController ()

@end

@implementation LQResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
      self.title = @"计算";
      
    
    UIButton *reckonBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 61)];
    [reckonBtn setTitle:@"计算" forState:UIControlStateNormal];
    reckonBtn.backgroundColor = UIColor.darkGrayColor;
    [reckonBtn addTarget:self action:@selector(reckon) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reckonBtn];
    
}

-(void)reckon{
    LQDijkstraTool *tool = LQDijkstraTool.new;
    tool.linesArray =  @[
        @[@"A",@"B",@"12"],
        @[@"A",@"G",@"14"],
        @[@"A",@"F",@"16"],
        @[@"B",@"C",@"10"],
        @[@"B",@"F",@"7"],
        @[@"G",@"F",@"14"],
        @[@"G",@"E",@"8"],
        @[@"F",@"C",@"6"],
        @[@"F",@"E",@"2"],
        @[@"C",@"D",@"3"],
        @[@"C",@"E",@"5"],
        @[@"E",@"D",@"4"]];
    
    CGFloat value =  tool.getDijkstra;
    NSLog(@"value = %.f",value);
}


@end
