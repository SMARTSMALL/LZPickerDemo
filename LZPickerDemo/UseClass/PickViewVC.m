//
//  PickViewVC.m
//  smart_small
//
//  Created by LZ on 2017/7/4.
//  Copyright © 2017年 LZ. All rights reserved.
//

#import "PickViewVC.h"
#import "PickTestViewController.h"
#import "ChoseDatePickViewController.h"
#import "LZPickViewManager.h"
@interface PickViewVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSMutableArray *titleArray;

@end

@implementation PickViewVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择器";
    self.titleArray = [NSMutableArray arrayWithObjects:@"底部弹出自定义数据源选择器",@"时间选择器",@"地址选择器", nil];
    [self tableViewLayout];
}

- (void)tableViewLayout{
    UITableView *tabelView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    tabelView.delegate = self;
    tabelView.dataSource = self;
    [self.view addSubview:tabelView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            PickTestViewController * test = [[PickTestViewController alloc]init];
            [self.navigationController pushViewController:test animated:YES];
            NSLog(@"自定义选择器");
        }
            break;
        case 1:
        {
            
            ChoseDatePickViewController * vc = [[ChoseDatePickViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }
            break;
        case 2:
            
            [[LZPickViewManager initLZPickerViewManager]showWithAddressPickerCompltedBlock:^(NSString *choseAddress,NSString *province , NSString *provinceID , NSString * city , NSString * cityId , NSString *area ,NSString *areaId) {
                
                NSLog(@"选择的地址是:%@",choseAddress);
                NSLog(@"选择的省是:%@",province);
                NSLog(@"选择的省ID是:%@",provinceID);
                NSLog(@"选择的市是:%@",city);
                NSLog(@"选择的市ID是:%@",cityId);
                NSLog(@"选择的区是:%@",area);
                NSLog(@"选择的区ID是:%@",areaId);
                
            } cancleBlock:^{
                
            }];
            
            NSLog(@"地址选择器");
            break;
        default:
            break;
    }
}

- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}


@end
