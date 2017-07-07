//
//  LZMultiplePickerView.m
//  smart_small
//
//  Created by LZ on 2017/7/6.
//  Copyright © 2017年 LZ. All rights reserved.
//

#import "LZMultiplePickerView.h"
@interface LZMultiplePickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSInteger _component01Index;
    NSInteger _component02Index;
    NSInteger _component03Index;
    
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
@implementation LZMultiplePickerView

//类方法
+ (instancetype)initMultiplePicker{
    
    return  [[self alloc]init];
}

- (instancetype)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if (self) {
        [self initToolBar];
        [self initMaskView];

        _component01Index = _component02Index = _component03Index =0;
        
        self.backgroundColor = [UIColor whiteColor];
        self.dataSource = self;
        self.delegate = self;
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

- (void)showWithData:(NSArray *)data withComponentCount:(int)componentCount withCompltedBlock:(void (^)(NSString *componentOneShow,NSString * componentOneBack,NSString *componentTwoShow,NSString * componentTwoBack,NSString *componentThreeShow,NSString * componentThreeBack))compltedBlock cancelBlock:(void (^)())cancelBlock{
    
    self.LZPickerClickSureHandle = compltedBlock;
    self.LZPickerClickCancleHandle = cancelBlock;
    
    self.componentCount = componentCount;
    
    self.arrayDS = [data copy];
    [self showWithAnimation];
    __weak typeof(self) weakSelf = self;
    
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
    
    if (self.componentCount==1) {
        [self hiddenWithAnimation];
        
        
        if (self.LZPickerClickSureHandle) {
            
            if (self.componentOneShowKey!=nil) {
                self.LZPickerClickSureHandle(self.arrayDS[_component01Index][self.componentOneShowKey],self.arrayDS[_component01Index][self.componentOneBackKey],nil,nil,nil,nil);
            }else{
                self.LZPickerClickSureHandle(self.arrayDS[_component01Index],nil,nil,nil,nil,nil);
            }
            
            
        }
    }else if (self.componentCount==2)
    {
        
        [self hiddenWithAnimation];
        if (self.LZPickerClickSureHandle) {
            self.LZPickerClickSureHandle(self.arrayDS[_component01Index][self.componentOneShowKey],self.arrayDS[_component01Index][self.componentOneBackKey],self.arrayDS[_component01Index][self.componentOneChildKey][_component02Index][self.componentTwoShowKey],self.arrayDS[_component01Index][self.componentOneChildKey][_component02Index][self.componentTwoBackKey],nil,nil);
        }
        
        
        
    }else{
        
        [self hiddenWithAnimation];
        if (self.LZPickerClickSureHandle) {
            self.LZPickerClickSureHandle(self.arrayDS[_component01Index][self.componentOneShowKey],self.arrayDS[_component01Index][self.componentOneBackKey],self.arrayDS[_component01Index][self.componentOneChildKey][_component02Index][self.componentTwoShowKey],self.arrayDS[_component01Index][self.componentOneChildKey][_component02Index][self.componentTwoBackKey],self.arrayDS[_component01Index][self.componentOneChildKey][_component02Index][self.componentTwoChildKey][_component03Index][self.componentThreeShowKey],self.arrayDS[_component01Index][self.componentOneChildKey][_component02Index][self.componentTwoChildKey][_component03Index][self.componentThreeBackKey]);
        }
        
    }
    
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
    
    return self.componentCount;
    
}
// 每列有多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if (self.componentCount==1) {
        return self.arrayDS.count;
    }else if(self.componentCount==2){
        
        if (component==0) {
            return self.arrayDS.count;
        }else{
            return [self.arrayDS[_component01Index][self.componentOneChildKey] count];
        }
        
    }else{
        
        if(component == 0){
            return self.arrayDS.count;
        }
        else if (component == 1){
            return [self.arrayDS[_component01Index][self.componentOneChildKey]count];
        }
        else{
            
            return [self.arrayDS[_component01Index][self.componentOneChildKey][_component02Index][self.componentTwoChildKey] count];
        }
    }
    
}
// 返回每一行的内容
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    
    if (self.componentCount==1) {
        
        if (self.componentOneShowKey!=nil) {
            return self.arrayDS[row][self.componentOneShowKey];
        }else{
            return self.arrayDS[row];
        }
        
        
    }else if (self.componentCount==2)
    {
        
        if(component == 0){
            return self.arrayDS[row][self.componentOneShowKey];
        }
        else {
            
            return self.arrayDS[_component01Index][self.componentOneChildKey][row][self.componentTwoShowKey];
        }
    }else{
        if(component == 0){
            
            return self.arrayDS[row][self.componentOneShowKey];
        }
        else if (component == 1){
            return self.arrayDS[_component01Index][self.componentOneChildKey][row][self.componentTwoShowKey];
        }
        else{
            
            return self.arrayDS[_component01Index][self.componentOneChildKey][_component02Index][self.componentTwoChildKey][row][self.componentThreeShowKey];
        }
    }
    
    
}

// 滑动或点击选择，确认pickerView选中结果
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.componentCount==1) {
        
        _component01Index = row;
        
        
    }else if (self.componentCount==2)
    {
        if (component==0) {
            _component01Index = row;
            _component02Index = 0;
            [pickerView reloadComponent:1];
            [pickerView selectRow:0 inComponent:1 animated:YES];
            
        }else{
            _component02Index = row;
        }
        
    }else{
        
        if (component==0) {
            _component01Index = row;
            _component02Index = 0;
            [pickerView reloadComponent:1];
            [pickerView selectRow:0 inComponent:1 animated:YES];
            
            
        }else if(component==1){
            _component02Index = row;
            _component03Index = 0;
            [pickerView selectRow:0 inComponent:2 animated:YES];
            [pickerView reloadComponent:2];
        }else{
            
            _component03Index = row;
        }
        
    }
    
}
// 重置当前选中项

- (void)resetPickerSelectRow{
    
    [self selectRow:_component01Index inComponent:0 animated:YES];
    
    // [self reloadAllComponents];
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

#pragma getter/setter

- (void)setComponentOneShowKey:(NSString *)componentOneShowKey
{
    _componentOneShowKey = componentOneShowKey;
}

- (void)setComponentOneBackKey:(NSString *)componentOneBackKey
{
    _componentOneBackKey = componentOneBackKey;
}

- (void)setComponentOneChildKey:(NSString *)componentOneChildKey
{
    _componentOneChildKey = componentOneChildKey;
    
}
- (void)setComponentTwoShowKey:(NSString *)componentTwoShowKey
{
    _componentTwoShowKey = componentTwoShowKey;
}

- (void)setComponentTwoBackKey:(NSString *)componentTwoBackKey
{
    _componentTwoBackKey = componentTwoBackKey;
}


- (void)setComponentTwoChildKey:(NSString *)componentTwoChildKey
{
    _componentTwoChildKey = componentTwoChildKey;
    
}
- (void)setComponentThreeShowKey:(NSString *)componentThreeShowKey
{
    _componentThreeShowKey = componentThreeShowKey;
}

- (void)setComponentThreeBackKey:(NSString *)componentThreeBackKey
{
    _componentThreeBackKey = componentThreeBackKey;
}



@end
