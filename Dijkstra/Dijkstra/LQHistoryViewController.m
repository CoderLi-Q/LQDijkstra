//
//  LQHistoryViewController.m
//  Dijkstra
//
//  Created by Schaffer on 2020/7/8.
//  Copyright © 2020 LQ. All rights reserved.
//

#import "LQHistoryViewController.h"
#import "LQDataCache.h"
#import "LQResultViewController.h"
@interface LQHistoryViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) NSArray *dataArray;

@end

@implementation LQHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [LQDataCache getHistoryData:^(NSArray *array) {
        NSLog(@"%@",array);
        self.dataArray = [NSArray arrayWithArray:array];
        
    }];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell-hi"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell-hi"];
    }
    LQDataCacheModel *mode = self.dataArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@-%@",[mode.name stringByReplacingOccurrencesOfString:@".data" withString:@""],mode.points];
    cell.textLabel.numberOfLines = 0;
    
    return cell;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LQDataCacheModel *mode = self.dataArray[indexPath.row];
    LQResultViewController *result = [[LQResultViewController alloc] init];
    result.pathDatas = [NSArray arrayWithArray:mode.points];
    [self.navigationController pushViewController:result animated:YES];

}




-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}


-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

@end
