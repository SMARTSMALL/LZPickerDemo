//
//  LZAddressPickerView.m
//  smart_small
//
//  Created by LZ on 2017/7/5.
//  Copyright © 2017年 LZ. All rights reserved.
//

#import "LZAddressPickerView.h"

@interface LZAddressPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>{
    
    NSInteger _provinceIndex;   // 省份选择 记录
    NSInteger _cityIndex;       // 市选择 记录
    NSInteger _districtIndex;   // 区选择 记录
}
/**  容器 **/
@property(nonatomic,strong)UIView * containerView;
/**  背景蒙版 **/
@property(nonatomic,strong)UIView * maskView;

/**  选中的row **/
@property (nonatomic,assign)NSInteger selectRow;

@property(nonatomic,copy)NSString * seletedString;
//数据源
@property(nonatomic,strong)NSArray * arrayDS;

@end
@implementation LZAddressPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initToolBar];
        [self initMaskView];
        
        _provinceIndex=  _cityIndex = _districtIndex = 0;
        
        self.backgroundColor = [UIColor whiteColor];
        self.dataSource = self;
        self.delegate = self;
        [self initContainerView];
        
        NSDictionary * arrayDict = [[NSDictionary alloc]initWithContentsOfFile:BundlePath(@"goldeneyeAddress")];
        
        if (arrayDict && arrayDict.count>0) {
            if ([arrayDict[@"Type"] isEqualToString:@"Success"]) {
                NSArray * array = arrayDict[@"Data"];
                if (array.count>0) {
                    self.arrayDS = [array  copy];
                    // 默认Picker状态
                    [self resetPickerSelectRow];
                }
                
            }
            NSLog(@"come++++++");
        }
        
    }
    return self;
}
-(void)resetPickerSelectRow
{
    
    [self selectRow:_provinceIndex inComponent:0 animated:YES];
    [self reloadAllComponents];
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
- (void)showAddressPickerCompltedBlock:(void (^)(NSString *choseAddress,NSString *province , NSString *provinceID , NSString * city , NSString * cityId , NSString *area ,NSString *areaId))compltedBlock cancelBlock:(void (^)())cancelBlock{
    
    
    [self showWithAnimation];
    
    __weak typeof(self) weakSelf = self;
    
    
    self.LZPickerClickSureHandle = compltedBlock;
    self.LZPickerClickCancleHandle =  cancelBlock;
    
    
    [self.topView setLZPickTopViewClickHandle:^(ClickTopViewType type){
        if (type==ClickTopViewTypeWithLeft) {
            //取消
            [weakSelf cancleHandle];
        }else{
            //确定
            [weakSelf sureHandle];
        }
    }];
    
    
}

- (void)cancleHandle
{
    if ( self.LZPickerClickCancleHandle) {
        [self hiddenWithAnimation];
        self.LZPickerClickCancleHandle();
    }
    
}

- (void)sureHandle{
    
    if (self.LZPickerClickSureHandle) {
        [self hiddenWithAnimation];
        self.LZPickerClickSureHandle([self seletedStr],self.arrayDS[_provinceIndex][@"NodeName"],self.arrayDS[_provinceIndex][@"NodeId"],self.arrayDS[_provinceIndex][@"ChilrdCollection"][_cityIndex][@"NodeName"],self.arrayDS[_provinceIndex][@"ChilrdCollection"][_cityIndex][@"NodeId"],self.arrayDS[_provinceIndex][@"ChilrdCollection"][_cityIndex][@"ChilrdCollection"][_districtIndex][@"NodeName"],self.arrayDS[_provinceIndex][@"ChilrdCollection"][_cityIndex][@"ChilrdCollection"][_districtIndex][@"NodeId"]);
    }
    
}

- (NSString *)seletedStr{
    
    NSLog(@"省====%@",self.arrayDS[_provinceIndex][@"NodeName"]);
    NSLog(@"市====%@",self.arrayDS[_provinceIndex][@"ChilrdCollection"][_cityIndex][@"NodeName"]);
    NSLog(@"区====%@",self.arrayDS[_provinceIndex][@"ChilrdCollection"][_cityIndex][@"ChilrdCollection"][_districtIndex][@"NodeName"]);
    
    // 省市区地址
    NSString * address = [NSString stringWithFormat:@"%@-%@-%@", self.arrayDS[_provinceIndex][@"NodeName"], self.arrayDS[_provinceIndex][@"ChilrdCollection"][_cityIndex][@"NodeName"], self.arrayDS[_provinceIndex][@"ChilrdCollection"][_cityIndex][@"ChilrdCollection"][_districtIndex][@"NodeName"]];
    
    return address;
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

#pragma mark - UIPickerViewDelegate,UIPickerViewDataSource
// 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

// 每列有多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0){
        return self.arrayDS.count;
    }
    else if (component == 1){
        return [self.arrayDS[_provinceIndex][@"ChilrdCollection"]count];
    }
    else{
  
        return [self.arrayDS[_provinceIndex][@"ChilrdCollection"][_cityIndex][@"ChilrdCollection"] count];
    }
}
// 返回每一行的内容
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component == 0){
        return self.arrayDS[row][@"NodeName"];
    }
    else if (component == 1){
        return self.arrayDS[_provinceIndex][@"ChilrdCollection"][row][@"NodeName"];
    }
    else{
        return self.arrayDS[_provinceIndex][@"ChilrdCollection"][_cityIndex][@"ChilrdCollection"][row][@"NodeName"];
    }
}

// 滑动或点击选择，确认pickerView选中结果
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if(component == 0){
        _provinceIndex = row;
        _cityIndex = 0;
        _districtIndex = 0;
        
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }
    else if (component == 1){
        _cityIndex = row;
        _districtIndex = 0;
        [pickerView selectRow:0 inComponent:2 animated:YES];
        [pickerView reloadComponent:2];
    }
    else{
        _districtIndex = row;
    }

}

- (void)clearSpearatorLine
{
    for (UIView * subView1 in self.subviews)
    {
        if ([subView1 isKindOfClass:[UIPickerView class]])//取出UIPickerView
        {
            for(UIView * subView2 in subView1.subviews)
            {
                if (subView2.frame.size.height < 1)//取出分割线view
                {
                    subView2.backgroundColor = [UIColor redColor];
                    //subView2.hidden = YES;//隐藏分割线
                }
            }
        }
    }
}

@end
