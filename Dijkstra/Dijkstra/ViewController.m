//
//  ViewController.m
//  Dijkstra
//
//  Created by Schaffer on 2020/7/6.
//  Copyright © 2020 LQ. All rights reserved.
//

#import "ViewController.h"
#import "LQDijkstraTool.h"
@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    CGFloat value =  LQDijkstraTool.new.getDijkstra;
    NSLog(@"value = %.f",value);
  
    
}



@end
