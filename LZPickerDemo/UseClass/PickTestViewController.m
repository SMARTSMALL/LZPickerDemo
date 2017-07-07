
//
//  PickTestViewController.m
//  smart_small
//
//  Created by LZ on 2017/7/5.
//  Copyright © 2017年 LZ. All rights reserved.
//

#import "PickTestViewController.h"
#import "LZPickViewManager.h"

static NSString * const cellIdtentifier = @"cell";


@interface PickTestViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableV;

@property(nonatomic,strong)NSArray * datas;

@end

@implementation PickTestViewController


- (UITableView *)tableV
{
    if (!_tableV) {
        _tableV = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        // _tableV.separatorStyle = 0;
        [_tableV registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdtentifier];
    }
    return _tableV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title  = @"时间选择器";
    self.view.backgroundColor = [UIColor whiteColor];
    self.datas = [NSArray arrayWithObjects:@"1行 有数组+字典构成",@"1行 由纯数组构成",@"2行 数组嵌套",@"3行",nil];
    
    [self.view addSubview:self.tableV];
    
    
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdtentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdtentifier];
    }
    
    cell.textLabel.text = self.datas[indexPath.row];
    cell.textLabel.numberOfLines = 2;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row==0) {
        
        
        NSArray * array = [[NSArray alloc]initWithContentsOfFile:BundlePath(@"iPhone")];
        
        NSLog(@"array=====%@",array);
        
        LZPickViewManager * manager =  [LZPickViewManager initLZPickerViewManager];
        [manager setMultiPickerViewComponentOneShowKeyName:@"Name" withBackKeyName:@"ID"];
        [manager showMultiPickerViewWithData:array withComponentCount:1 withCompltedBlock:^(NSString *componentOneShow,NSString * componentOneBack,NSString *componentTwoShow,NSString * componentTwoBack,NSString *componentThreeShow,NSString * componentThreeBack) {
            
            
            
            NSString * showString = [NSString stringWithFormat:@"选择了:%@ ID是:%@",componentOneShow,componentOneBack];
            AlertShow(showString);
            
        } cancelBlock:^{
            
        }];
        
    }else if (indexPath.row==1)
    {
        NSArray * array = @[@"iPhone4",@"iPhone4s",@"iPhone5",@"iPhone5s",@"iPhone5c",@"iPhone6",@"iPhone6Plus",@"iPhone6s",@"iPhone6s plus",@"iPhone7"];
        
        
        NSLog(@"array=====%@",array);
        
        LZPickViewManager * manager =  [LZPickViewManager initLZPickerViewManager];

        [manager showMultiPickerViewWithData:array withComponentCount:1 withCompltedBlock:^(NSString *componentOneShow,NSString * componentOneBack,NSString *componentTwoShow,NSString * componentTwoBack,NSString *componentThreeShow,NSString * componentThreeBack) {
            
            NSString * showString = [NSString stringWithFormat:@"选择了:%@",componentOneShow];
            AlertShow(showString)
            
        } cancelBlock:^{
            
        }];
        
        
    }
    else if (indexPath.row==2)
    {
  
        NSArray * array = [[NSArray alloc]initWithContentsOfFile:BundlePath(@"Cars")];
  
        LZPickViewManager * manager =  [LZPickViewManager initLZPickerViewManager];
        
        [manager setMultiPickerViewComponentOneShowKeyName:@"cityName" withOneBackKeyName:@"Id" withOneChildKey:@"cars" withTwoShowKeyName:@"name" withTwoBackNameKeyName:@"Id"];

        [ manager showMultiPickerViewWithData:array withComponentCount:2 withCompltedBlock:^(NSString *componentOneShow,NSString * componentOneBack,NSString *componentTwoShow,NSString * componentTwoBack,NSString *componentThreeShow,NSString * componentThreeBack) {
            
            
            NSString * showString = [NSString stringWithFormat:@"选择了是1列 :%@ ID是:%@ \n 选择了是2列 :%@ ID是:%@",componentOneShow,componentOneBack,componentTwoShow,componentTwoBack];
            AlertShow(showString)
            
            
        } cancelBlock:^{
            
        }];
        
    }else if (indexPath.row==3)
    {
        //NSArray * array = [[NSArray alloc]initWithContentsOfFile:BundlePath(@"goldeneyeAddress")];
        
        NSDictionary * arrayDict = [[NSDictionary alloc]initWithContentsOfFile:BundlePath(@"goldeneyeAddress")];
        NSArray * arrayTwo;
        if (arrayDict && arrayDict.count>0) {
            if ([arrayDict[@"Type"] isEqualToString:@"Success"]) {
                NSArray * array = arrayDict[@"Data"];
                if (array.count>0) {
        
                    arrayTwo = [array  copy];
                }
            }
            NSLog(@"come++++++");
        }
        
        NSLog(@"array = %@",arrayTwo);
        
        
        LZPickViewManager * manager =  [LZPickViewManager initLZPickerViewManager];
        
        [manager setMultiPickerViewComponentOneShowKeyName:@"NodeName" withOneBackKeyName:@"NodeId" withOneChildKey:@"ChilrdCollection" withTwoShowKeyName:@"NodeName" withTwoBackNameKeyName:@"NodeId" withTwoChildKey:@"ChilrdCollection" withThreeShowKeyName:@"NodeName" withThreeBackNameKeyName:@"NodeId"];
        [ manager showMultiPickerViewWithData:arrayTwo withComponentCount:3 withCompltedBlock:^(NSString *componentOneShow,NSString * componentOneBack,NSString *componentTwoShow,NSString * componentTwoBack,NSString *componentThreeShow,NSString * componentThreeBack) {
            

            NSString * showString = [NSString stringWithFormat:@"选择了是1列 :%@ ID是:%@ \n 选择了是2列 :%@ ID是:%@ \n 选择了是3列 :%@ ID是:%@",componentOneShow,componentOneBack,componentTwoShow,componentTwoBack,componentThreeShow,componentThreeBack];
            AlertShow(showString)
            
            
        } cancelBlock:^{
            
        }];
    }
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
