//
//  FPSController.m
//  FPS_OC
//
//  Created by 薛林 on 16/12/16.
//  Copyright © 2016年 YunTianXia. All rights reserved.
//

#import "FPSController.h"
#import "FPS_OC.h"

@interface FPSController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FPSController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    [[FPS_OC sharedFps]start];
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = @"😝-💐-🌹—😢-😂😝-💐-🌹—😢-😂😝-💐-🌹—😢-😂😝-💐-🌹—😢-😂😝-💐-🌹—😢-😂😝-💐-🌹—😢-😂😝-💐-🌹—😢-😂😝-💐-🌹—😢-😂😝-💐-🌹—😢-😂😝-💐-🌹—😢-😂😝-💐-🌹—😢-😂😝-💐-🌹—😢-😂😝-💐-🌹—😢-😂😝-💐-🌹—😢-😂😝-💐-🌹—😢-😂😝-💐-🌹—😢-😂😝-💐-🌹—😢-😂😝-💐-🌹—😢-😂😝-💐-🌹—😢-😂😝-💐-🌹—😢-😂😝-💐-🌹—😢-😂😝-💐-🌹—😢-😂😝-💐-🌹—😢-😂😝-💐-🌹—😢-😂😝-💐-🌹—😢-😂😝-💐-🌹—😢-😂😝-💐-🌹—😢-😂😝-💐-🌹—😢-😂😝-💐-🌹—😢-😂😝-💐-🌹—😢-😂";
    
    return cell;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 400;
    }
    return _tableView;
}


@end
