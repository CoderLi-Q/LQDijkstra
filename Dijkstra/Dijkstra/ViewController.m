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
#import "LQDataCache.h"
#import "LQHistoryViewController.h"
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
    {
    UIButton *history = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 61)];
       [history setTitle:@"历史记录" forState:UIControlStateNormal];
       history.backgroundColor = UIColor.darkGrayColor;
       [history addTarget:self action:@selector(history) forControlEvents:UIControlEventTouchUpInside];
       [self.view addSubview:history];
    }
    
    LQDataView *dataView = [[LQDataView alloc] initWithFrame:CGRectMake(0, 200, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height-150)];
    dataView.number = 7;
    self.dataView = dataView;
    dataView.backgroundColor = UIColor.lightGrayColor;
    [self.view addSubview:dataView];
    
       
}
-(void)history{
    
    LQHistoryViewController *history = [[LQHistoryViewController alloc] init];
    [self.navigationController pushViewController:history animated:YES];
    
}

-(void)praparedBtnClick{
    if(self.dataView.pathDatas.count == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请划线" message:@"还没有连接" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    [LQDataCache addHistory:self.dataView.pathDatas];
    LQResultViewController *result = [[LQResultViewController alloc] init];
    result.pathDatas = [NSArray arrayWithArray:self.dataView.pathDatas];
    [self.navigationController pushViewController:result animated:YES];
}




@end
