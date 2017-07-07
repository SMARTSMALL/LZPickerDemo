

//
//  ChoseDatePickViewController.m
//  smart_small
//
//  Created by LZ on 2017/7/5.
//  Copyright © 2017年 LZ. All rights reserved.
//

#import "ChoseDatePickViewController.h"
#import "LZPickViewManager.h"

static NSString * const cellIdtentifier = @"cell";


@interface ChoseDatePickViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableV;

@property(nonatomic,strong)NSArray * datas;

@end

@implementation ChoseDatePickViewController


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
    self.datas = [NSArray arrayWithObjects:@"设置DatePickView UIDatePickerModeTime",@"设置DatePickView UIDatePickerModeDate",@"设置DatePickView UIDatePickerModeDateAndTime",@"设置DatePickView UIDatePickerModeCountDownTimer",@"设置MaxDate 2020-08-04",@"设置MinDate 1993-08-04",@"设置指定Date 1995-08-04",@"设置MaxDate(2020-08-04)、MinDate(1993-08-04)、指定Date(1995-08-04)",@"设置顶部leftButton、rightButton、title 内容",@"设置顶部leftButton、rightButton、title bg 颜色",@"设置顶部View的高度 40.0f 变为100.0f",@"自定义限制时间的DatePicker 默认最大最小时间",@"自定义DatePicker 设置最大时间 2020-12-31 最小时间1993-01-01",@"自定义DatePicker 设置最大时间为当天",@"设置最大时间比当前时间大",@"设置最大时间比当前时间小",@"自定义DatePicker 最小时间为当天",@"设置最小时间比当前时间大",@"设置最小时间比当前时间小",nil];
    
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
        [[LZPickViewManager initLZPickerViewManager] showWithDatePickerMode:UIDatePickerModeTime compltedBlock:^(NSDate *choseDate) {
            
        } cancelBlock:^{
            
        }];
        
    }else if (indexPath.row==1)
    {
        [[LZPickViewManager initLZPickerViewManager] showWithDatePickerMode:UIDatePickerModeDate compltedBlock:^(NSDate *choseDate) {
            
        } cancelBlock:^{
            
        }];
    }else if (indexPath.row==2)
    {
        [[LZPickViewManager initLZPickerViewManager] showWithDatePickerMode:UIDatePickerModeDateAndTime compltedBlock:^(NSDate *choseDate) {
            
        } cancelBlock:^{
            
        }];
    }else if (indexPath.row==3)
    {
        [[LZPickViewManager initLZPickerViewManager] showWithDatePickerMode:UIDatePickerModeCountDownTimer compltedBlock:^(NSDate *choseDate) {
            
        } cancelBlock:^{
            
        }];
    }else if (indexPath.row==4)
    {
        LZPickViewManager * shareManager = [LZPickViewManager initLZPickerViewManager];
        //            由 NSString 转换为 NSDate:
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        NSDate *maxDate = [dateFormatter dateFromString:@"2020-08-04"];
        
        //设置最大、最小、当前
        [shareManager setDatePickerWithMaxDate:maxDate withMinDate:nil withFixedValueDate:nil];
        
        [shareManager showWithDatePickerMode:UIDatePickerModeDate compltedBlock:^(NSDate *choseDate) {
            
        } cancelBlock:^{
            
        }];
        
    }else if (indexPath.row==5)
    {
        LZPickViewManager * shareManager = [LZPickViewManager initLZPickerViewManager];
        //            由 NSString 转换为 NSDate:
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        
        NSDate *minDate = [dateFormatter dateFromString:@"1993-08-04"];
        
        //设置最大、最小、当前
        [shareManager setDatePickerWithMaxDate:nil withMinDate:minDate withFixedValueDate:nil];
        
        [shareManager showWithDatePickerMode:UIDatePickerModeDate compltedBlock:^(NSDate *choseDate) {
            
        } cancelBlock:^{
            
        }];
        
    }else if (indexPath.row==6)
    {
        LZPickViewManager * shareManager = [LZPickViewManager initLZPickerViewManager];
        //            由 NSString 转换为 NSDate:
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        
        NSDate *fixedValueDate = [dateFormatter dateFromString:@"1995-08-04"];
        //设置最大、最小、当前
        [shareManager setDatePickerWithMaxDate:nil withMinDate:nil withFixedValueDate:fixedValueDate];
        
        [shareManager showWithDatePickerMode:UIDatePickerModeDate compltedBlock:^(NSDate *choseDate) {
            
        } cancelBlock:^{
            
        }];
        
    }else if (indexPath.row==7)
    {
        LZPickViewManager * shareManager = [LZPickViewManager initLZPickerViewManager];
        //            由 NSString 转换为 NSDate:
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        NSDate *maxDate = [dateFormatter dateFromString:@"2020-08-04"];
        
        NSDate *minDate = [dateFormatter dateFromString:@"1993-08-04"];
        NSDate *fixedValueDate = [dateFormatter dateFromString:@"1995-08-04"];
        //设置最大、最小、当前
        [shareManager setDatePickerWithMaxDate:maxDate withMinDate:minDate withFixedValueDate:fixedValueDate];
        
        [shareManager showWithDatePickerMode:UIDatePickerModeDate compltedBlock:^(NSDate *choseDate) {
            
        } cancelBlock:^{
            
        }];
        
    }else if (indexPath.row==8)
    {
        LZPickViewManager * shareManager = [LZPickViewManager initLZPickerViewManager];
        [shareManager setPickViewTopWithLeftButtonString:@"cancle" withRightButtonString:@"done" withTitleString:@"请选择时间"];
        
        [shareManager showWithDatePickerMode:UIDatePickerModeDate compltedBlock:^(NSDate *choseDate) {
            
        } cancelBlock:^{
            
        }];
        
    }else if (indexPath.row==9)
    {
        LZPickViewManager * shareManager = [LZPickViewManager initLZPickerViewManager];
        [shareManager setPickViewTopWithLeftButtonColor:[UIColor redColor] withRightButtonColor:[UIColor greenColor] withTitleColor:[UIColor purpleColor] withTopBgColor:[UIColor groupTableViewBackgroundColor]];
        [shareManager showWithDatePickerMode:UIDatePickerModeDate compltedBlock:^(NSDate *choseDate) {
            
        } cancelBlock:^{
            
        }];
        
    }else if (indexPath.row==10)
    {
        LZPickViewManager * shareManager = [LZPickViewManager initLZPickerViewManager];
        [shareManager setPickViewWithTopHeight:100.0f];
        [shareManager showWithDatePickerMode:UIDatePickerModeDate compltedBlock:^(NSDate *choseDate) {
            
        } cancelBlock:^{
            
        }];
        
    }else if (indexPath.row==11)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        //NSDate *maxDate = [dateFormatter dateFromString:@"2020-08-04"];
        
        //NSDate *minDate = [dateFormatter dateFromString:@"1993-08-04"];

        [[LZPickViewManager initLZPickerViewManager] showWithMaxDateString:@"" withMinDateString:@"" didSeletedDateStringBlock:^(NSString *dateString) {

            NSString * showString = [NSString stringWithFormat:@"选择了时间是%@",dateString];
            AlertShow(showString)

        }];

    }else if (indexPath.row==12)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        //NSDate *maxDate = [dateFormatter dateFromString:@"2020-08-04"];
        
        //NSDate *minDate = [dateFormatter dateFromString:@"1993-08-04"];
        
        [[LZPickViewManager initLZPickerViewManager] showWithMaxDateString:@"2020-08-06" withMinDateString:@"1993-01-01" didSeletedDateStringBlock:^(NSString *dateString) {
            
            NSString * showString = [NSString stringWithFormat:@"选择了时间是%@",dateString];
            AlertShow(showString)
            
        }];
        
    }else if (indexPath.row==13)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        

        [[LZPickViewManager initLZPickerViewManager] showWithMaxDateString:[self getCurrentTimeWithFormat:@"yyyy-MM-dd"] withMinDateString:nil didSeletedDateStringBlock:^(NSString *dateString) {
            NSString * showString = [NSString stringWithFormat:@"选择了时间是%@",dateString];
            AlertShow(showString)
            
        }];
    }else if (indexPath.row==14)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        
        [[LZPickViewManager initLZPickerViewManager] showWithMaxDateString:[self getCurrentTimeWithFormat:@"2030-02-02"] withMinDateString:nil didSeletedDateStringBlock:^(NSString *dateString) {
            NSString * showString = [NSString stringWithFormat:@"选择了时间是%@",dateString];
            AlertShow(showString)
            
        }];
    }else if (indexPath.row==15)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        
        [[LZPickViewManager initLZPickerViewManager] showWithMaxDateString:[self getCurrentTimeWithFormat:@"1993-01-02"] withMinDateString:nil didSeletedDateStringBlock:^(NSString *dateString) {
            NSString * showString = [NSString stringWithFormat:@"选择了时间是%@",dateString];
            AlertShow(showString)
            
        }];
    }
    

    

    
    else if (indexPath.row==16)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        

        
        [[LZPickViewManager initLZPickerViewManager] showWithMaxDateString:nil withMinDateString:[self getCurrentTimeWithFormat:@"yyyy-MM-dd"] didSeletedDateStringBlock:^(NSString *dateString) {
            
            NSString * showString = [NSString stringWithFormat:@"选择了时间是%@",dateString];
            AlertShow(showString)
            
        }];
        
    }
    else if (indexPath.row==17)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        [[LZPickViewManager initLZPickerViewManager] showWithMaxDateString:nil withMinDateString:@"2020-08-20" didSeletedDateStringBlock:^(NSString *dateString) {
            
            NSString * showString = [NSString stringWithFormat:@"选择了时间是%@",dateString];
            AlertShow(showString)
            
        }];
        
    }
    else if (indexPath.row==18)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        

        [[LZPickViewManager initLZPickerViewManager] showWithMaxDateString:nil withMinDateString:@"1990-02-28" didSeletedDateStringBlock:^(NSString *dateString) {
            
            NSString * showString = [NSString stringWithFormat:@"选择了时间是%@",dateString];
            AlertShow(showString)
            
        }];
        
    }
    
    
    
}



- (NSString *)getCurrentTimeWithFormat:(NSString *)format{
    
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat: format];
    NSString *DateTime = [formatter stringFromDate:date];
    
    return DateTime;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
