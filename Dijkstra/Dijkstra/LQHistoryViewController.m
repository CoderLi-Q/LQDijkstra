//
//  LQHistoryViewController.m
//  Dijkstra
//
//  Created by Schaffer on 2020/7/8.
//  Copyright © 2020 LQ. All rights reserved.
//

#import "LQHistoryViewController.h"
#import "LQDataCache.h"
@interface LQHistoryViewController ()

@end

@implementation LQHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [LQDataCache getHistoryData:^(NSArray *array) {
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
