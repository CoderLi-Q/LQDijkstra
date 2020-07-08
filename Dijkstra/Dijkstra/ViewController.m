//
//  ViewController.m
//  Dijkstra
//
//  Created by Schaffer on 2020/7/6.
//  Copyright © 2020 LQ. All rights reserved.
//

#import "ViewController.h"
#import "LQResultViewController.h"
#import "LQDataView.h"
@interface ViewController ()

@property (nonatomic , weak) LQDataView *dataView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"准备数据";
    
    
    //准备数据,画线(后续提供画图能力)
    UIButton *praparedBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 61)];
       [praparedBtn setTitle:@"准备好了" forState:UIControlStateNormal];
       praparedBtn.backgroundColor = UIColor.darkGrayColor;
       [praparedBtn addTarget:self action:@selector(praparedBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [self.view addSubview:praparedBtn];
    
    
    
    LQDataView *dataView = [[LQDataView alloc] initWithFrame:CGRectMake(0, 200, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height-150)];
    dataView.number = 7;
    self.dataView = dataView;
    dataView.backgroundColor = UIColor.lightGrayColor;
    [self.view addSubview:dataView];
    
       
}
-(void)praparedBtnClick{
    LQResultViewController *result = [[LQResultViewController alloc] init];
    result.pathDatas = [NSArray arrayWithArray:self.dataView.pathDatas];
    [self.navigationController pushViewController:result animated:YES];
}




@end
