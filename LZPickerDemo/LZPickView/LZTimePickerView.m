
//
//  LZTimePickerView.m
//  smart_small
//
//  Created by LZ on 2017/7/5.
//  Copyright © 2017年 LZ. All rights reserved.
//

#import "LZTimePickerView.h"
#import "LZPickViewDefine.h"
#import "LZPickTopView.h"

@interface LZTimePickerView()
/**  数据源   **/
@property(nonatomic,strong)NSMutableArray * dataArray;
/**  容器 **/
@property(nonatomic,strong)UIView * containerView;
/**  背景蒙版 **/
@property(nonatomic,strong)UIView * maskView;
/**  选中的row **/
@property (nonatomic,assign)NSInteger selectRow;

@property(nonatomic,assign)UIDatePickerMode defaultTimeMode;
/**  记录选择的日期 **/
@property(nonatomic,strong)NSDate * choseDate;
@end

@implementation LZTimePickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    

    self = [super initWithFrame:frame];
    if (self) {
        
        
        [self initToolBar];
        [self initMaskView];
        
        self.defaultTimeMode = UIDatePickerModeTime;
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
        
        
        [self initContainerView];
    }
    return self;
}
- (void)initToolBar{
    
    self.topView = [LZPickTopView pickTopView];
}
- (void)initMaskView{
    self.maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kPICKVIEW_SCREEN_WIDTH, kPICKVIEW_SCREEN_HEIGHT)];
    self.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    self.maskView.userInteractionEnabled = YES;
    [ self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenWithAnimation)]];
}

- (void)initContainerView{

    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, kPICKVIEW_SCREEN_HEIGHT - self.frame.size.height - CGRectGetHeight(self.topView.frame), kPICKVIEW_SCREEN_WIDTH, self.frame.size.height + self.topView.frame.size.height)];
}


#pragma mark - Action
- (void)showWithDatePickerMode:(UIDatePickerMode)mode
                 compltedBlock:(void (^)(NSDate *choseDate))compltedBlock
                   cancelBlock:(void (^)())cancelBlock{
    
    self.datePickerMode = mode;
    //默认为0
    self.selectRow = 0;
    [self showWithAnimation];

    self.LZPickerClickSureHandle = compltedBlock;
    self.LZPickerClickCancleHandle =  cancelBlock;
    
    __weak LZTimePickerView * weakPickerView = self;
    
    [self.topView setLZPickTopViewClickHandle:^(ClickTopViewType type){
        if (type==ClickTopViewTypeWithLeft) {
            //取消
            [weakPickerView cancleHandle];
        }else{
            //确定
            [weakPickerView sureHandle];
        }
    }];
    
}

- (void)cancleHandle{
    
    if (self.LZPickerClickCancleHandle) {
        [self hiddenWithAnimation];
        self.LZPickerClickCancleHandle();
    }
}
- (void)sureHandle{
    
    if (self.LZPickerClickSureHandle) {
        [self hiddenWithAnimation];
        
        if (!self.choseDate) {
            self.LZPickerClickSureHandle([NSDate date]);
        }else{
            self.LZPickerClickSureHandle(self.choseDate);
        }
    }
}
//时间选择器滚动改变
- (void)dateChanged:(id)sender{
    
    NSDate* _date = self.date;

    self.choseDate = _date;
    /*添加你自己响应代码*/
}
- (void)showWithAnimation{
    
    [self addViews];
    self.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    
    
    [self.containerView setFrame:CGRectMake(0, kPICKVIEW_SCREEN_HEIGHT - self.frame.size.height - CGRectGetHeight(self.topView.frame), kPICKVIEW_SCREEN_WIDTH, self.frame.size.height + self.topView.frame.size.height)];
    
    CGFloat height = self.containerView.frame.size.height;

    self.containerView.center = CGPointMake(kPICKVIEW_SCREEN_WIDTH / 2, kPICKVIEW_SCREEN_HEIGHT + height / 2);
    [UIView animateWithDuration:0.25 animations:^{
        self.containerView.center = CGPointMake(kPICKVIEW_SCREEN_WIDTH / 2, kPICKVIEW_SCREEN_HEIGHT - height / 2);
        self.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    }];
    
}
- (void)hiddenWithAnimation
{
    CGFloat height = self.containerView.frame.size.height;
    [UIView animateWithDuration:0.25 animations:^{
        self.containerView.center = CGPointMake(kPICKVIEW_SCREEN_WIDTH / 2, kPICKVIEW_SCREEN_HEIGHT + height / 2);
        self.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    } completion:^(BOOL finished) {
        [self hiddenViews];
    }];
    
}
- (void)addViews{
    [self removeFromSuperview];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.maskView];
    [window addSubview:self.containerView];
    [self.containerView addSubview:self.topView];
    [self.containerView addSubview:self];
    self.frame = CGRectMake(0, CGRectGetHeight(self.topView.frame), kPICKVIEW_SCREEN_WIDTH, 216);
    
}
- (void)hiddenViews {
    [self removeFromSuperview];
    [self.topView removeFromSuperview];
    [self.maskView removeFromSuperview];
    [self.containerView removeFromSuperview];
}

#pragma mark lazy

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (void)setMaxDate:(NSDate *)maxDate

{
    self.maxDate = maxDate;
    
    [self setMaximumDate:maxDate];

}

- (void)setMinDate:(NSDate *)minDate
{
    
    self.minDate = minDate;
    

    [self setMinimumDate:minDate];
}
- (void)setFixedValueDate:(NSDate *)fixedValueDate
{

}

- (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
    
}




@end
