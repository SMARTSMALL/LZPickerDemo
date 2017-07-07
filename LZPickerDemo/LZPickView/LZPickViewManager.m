
//
//  LZPickViewManager.m
//  smart_small
//
//  Created by LZ on 2017/7/5.
//  Copyright © 2017年 LZ. All rights reserved.
//

#import "LZPickViewManager.h"

@implementation LZPickViewManager
+ (instancetype)initLZPickerViewManager{
    return  [[self alloc]init];
}
- (void)showWithDatePickerMode:(UIDatePickerMode)mode
                 compltedBlock:(void(^)(NSDate *choseDate))compltedBlock
                   cancelBlock:(void (^)())cancelBlock{
    [self.timePickerView showWithDatePickerMode:mode compltedBlock:^(NSDate *choseDate) {
        
    } cancelBlock:^{
        if (cancelBlock) {
            cancelBlock();
        }
    }];
}

//设置时间选择器 最大、最小、固定date
- (void)setDatePickerWithMaxDate:(NSDate *)maxDate
                     withMinDate:(NSDate *)minDate
              withFixedValueDate:(NSDate *)fixedValueDate{
    
    if (maxDate!=nil) {
        
        [self.timePickerView setMaximumDate:maxDate];
    }
    if (minDate!=nil) {
        [self.timePickerView setMinimumDate:minDate];
    }
    if (fixedValueDate!=nil) {
        
        [self.timePickerView setDate:fixedValueDate animated:YES];
    }
}




//显示地址三级联动选择器
- (void)showWithAddressPickerCompltedBlock:(void(^)(NSString *choseAddress,NSString *province , NSString *provinceID , NSString * city , NSString * cityId , NSString *area ,NSString *areaId))compltedBlock cancleBlock:(void(^)())cancelBlock{
    
    [self.addressPickerView  showAddressPickerCompltedBlock:^(NSString *choseAddress,NSString *province , NSString *provinceID , NSString * city , NSString * cityId , NSString *area ,NSString *areaId) {
        if (compltedBlock) {
            compltedBlock(choseAddress,province,provinceID,city,cityId,area,areaId);
        }
    } cancelBlock:^{
        if (cancelBlock) {
            cancelBlock();
        }
    }];
}



//显示自定义单条，多条选择器
- (void)showMultiPickerViewWithData:(NSArray *)array
                 withComponentCount:(int)componentCount
                  withCompltedBlock:(void (^)(NSString *componentOneShow,NSString * componentOneBack,NSString *componentTwoShow,NSString * componentTwoBack,NSString *componentThreeShow,NSString * componentThreeBack))compltedBlock   cancelBlock:(void (^)())cancelBlock{
    
    
    [self.multiPickerView showWithData:array withComponentCount:componentCount withCompltedBlock:^(NSString *componentOneShow,NSString * componentOneBack,NSString *componentTwoShow,NSString * componentTwoBack,NSString *componentThreeShow,NSString * componentThreeBack) {
        if (compltedBlock) {
            compltedBlock(componentOneShow,componentOneBack,componentTwoShow,componentTwoBack,componentThreeShow,componentThreeBack);
        }
    } cancelBlock:^{
        if (cancelBlock) {
            cancelBlock();
        }
    }];
    
}
//设置单条 显示的key、返回key
- (void)setMultiPickerViewComponentOneShowKeyName:(NSString *)showKeyName
                                  withBackKeyName:(NSString *)backNameKey{
    [self.multiPickerView setComponentOneShowKey:showKeyName];
    [self.multiPickerView setComponentOneBackKey:backNameKey];
    
}

- (void)setMultiPickerViewComponentOneShowKeyName:(NSString *)oneShowKeyName
                               withOneBackKeyName:(NSString *)OnebackNameKey
                                  withOneChildKey:(NSString *)oneChildKey
                               withTwoShowKeyName:(NSString *)twoShowKeyName
                           withTwoBackNameKeyName:(NSString *)TwobackNameKey
{
    [self.multiPickerView setComponentOneShowKey:oneShowKeyName];
    [self.multiPickerView setComponentOneBackKey:OnebackNameKey];
    [self.multiPickerView setComponentOneChildKey:oneChildKey];
    [self.multiPickerView setComponentTwoShowKey:twoShowKeyName];
    [self.multiPickerView setComponentTwoBackKey:TwobackNameKey];
}
- (void)setMultiPickerViewComponentOneShowKeyName:(NSString *)oneShowKeyName
                               withOneBackKeyName:(NSString *)onebackNameKey
                                  withOneChildKey:(NSString *)oneChildKey
                               withTwoShowKeyName:(NSString *)twoShowKeyName
                           withTwoBackNameKeyName:(NSString *)twobackNameKey
                                  withTwoChildKey:(NSString *)twoChildKey
                             withThreeShowKeyName:(NSString *)threeShowKeyName
                         withThreeBackNameKeyName:(NSString *)threebackNameKey{
    
    [self.multiPickerView setComponentOneShowKey:oneShowKeyName];
    [self.multiPickerView setComponentOneBackKey:onebackNameKey];
    [self.multiPickerView setComponentOneChildKey:oneChildKey];
    [self.multiPickerView setComponentTwoShowKey:twoShowKeyName];
    [self.multiPickerView setComponentTwoBackKey:twobackNameKey];
    [self.multiPickerView setComponentTwoChildKey:twoChildKey];
    [self.multiPickerView setComponentThreeShowKey:threeShowKeyName];
    [self.multiPickerView setComponentThreeBackKey:threebackNameKey];
    
    
}

/*  设置Picker显示 最小-最大范围  默认范围为:1991-01-01 2300:12:31
 *  maxString 最大时间
 *  minString 最小时间
 *  dateStringBlock 选择日期回调
 */
- (void)showWithMaxDateString:(NSString *)maxString withMinDateString:(NSString *)minString didSeletedDateStringBlock:(void (^)(NSString *dateString))dateStringBlock{
    

    [self.limitDatePicker showWithMaxDateString:maxString withMinDateString:minString didSeletedDateStringBlock:^(NSString *dateString) {
        
        if (dateStringBlock) {
            dateStringBlock(dateString);
        }
    }];
    
    
}



- (LZTimePickerView *)timePickerView
{
    if (!_timePickerView) {
        _timePickerView = [[LZTimePickerView alloc]init];
        
    }
    return _timePickerView;
}

- (LZAddressPickerView *)addressPickerView
{
    if (!_addressPickerView) {
        _addressPickerView = [[LZAddressPickerView alloc]init];
    }
    return _addressPickerView;
}

- (LZMultiplePickerView *)multiPickerView
{
    if (!_multiPickerView) {
        
        _multiPickerView = [LZMultiplePickerView initMultiplePicker];
    }
    return _multiPickerView;
}

- (LZCustomLimitDatePicker *)limitDatePicker
{
    if (!_limitDatePicker) {
        _limitDatePicker = [LZCustomLimitDatePicker initCustomLimitDatePicker];
    }
    return _limitDatePicker;
}
#pragma mark 通用设置
//设置top leftbutton、rightButton、titleLabel string

- (void)setPickViewTopWithLeftButtonString:(NSString *)leftString
                     withRightButtonString:(NSString *)rightString
                           withTitleString:(NSString *)titleString{
    if (leftString!=nil) {
        self.timePickerView.topView.leftTitle = leftString;
    }
    if (rightString!=nil) {
        self.timePickerView.topView.rightTitle = rightString;
    }
    if (leftString!=nil) {
        
        self.timePickerView.topView.mainTitle = titleString;
    }
    
}
//设置top leftbutton、rightButton、titleLabel 颜色
- (void)setPickViewTopWithLeftButtonColor:(UIColor *)leftColor
                     withRightButtonColor:(UIColor *)rightColor
                           withTitleColor:(UIColor *)titleColor
                           withTopBgColor:(UIColor *)bgColor{
    
    if (leftColor!=nil) {
        
        self.timePickerView.topView.leftTitleColor = leftColor;
    }
    if (rightColor!=nil) {
        
        self.timePickerView.topView.rightTitleColor = rightColor;
        
    }
    if (titleColor!=nil) {
        
        self.timePickerView.topView.mainTitleColor = titleColor;
        
    }
    if (bgColor!=nil) {
        
        self.timePickerView.topView.bgColor = bgColor;
    }
    
}

- (void)setPickViewWithTopHeight:(CGFloat)height{
    
    self.timePickerView.topView.topHeight = height;
}

@end
