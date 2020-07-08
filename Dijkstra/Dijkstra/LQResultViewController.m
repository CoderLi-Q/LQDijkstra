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
@property (nonatomic , weak) UILabel *label;
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
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 150, 61)];
    self.label = label;
    label.textColor = UIColor.redColor;
    [self.view addSubview:label];
    
}

-(void)reckon{

    
    
    LQDijkstraTool *tool = LQDijkstraTool.new;
    tool.startPoint = @"D";
    tool.endPoint = @"A";
    tool.linesArray = self.pathDatas;
    
    CGFloat value =  tool.getDijkstra;
    NSLog(@"value = %.f",value);
    self.label.text = [NSString stringWithFormat:@"最短路径是长度：%.f",value];
}


@end
