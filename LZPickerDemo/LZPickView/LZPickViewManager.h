//
//  LZPickViewManager.h
//  smart_small
//
//  Created by LZ on 2017/7/5.
//  Copyright © 2017年 LZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZTimePickerView.h"
#import "LZAddressPickerView.h"
#import "LZMultiplePickerView.h"
#import "LZCustomLimitDatePicker.h"

@interface LZPickViewManager : NSObject

+ (instancetype)initLZPickerViewManager;
//时间选择器
@property(nonatomic,strong)LZTimePickerView * timePickerView;
//地址选择器
@property(nonatomic,strong)LZAddressPickerView * addressPickerView;
//自定义单条，多条选择器
@property(nonatomic,strong)LZMultiplePickerView * multiPickerView;
//自定义范围时间选择器
@property(nonatomic,strong)LZCustomLimitDatePicker * limitDatePicker;
//显示时间选择器
- (void)showWithDatePickerMode:(UIDatePickerMode)mode compltedBlock:(void (^)(NSDate *choseDate))compltedBlock cancelBlock:(void (^)())cancelBlock;
//设置时间选择器 最大、最小、固定date
- (void)setDatePickerWithMaxDate:(NSDate *)maxDate withMinDate:(NSDate *)minDate withFixedValueDate:(NSDate *)fixedValueDate;
//显示地址三级联动选择器
- (void)showWithAddressPickerCompltedBlock:(void(^)(NSString *choseAddress,NSString *province , NSString *provinceID , NSString * city , NSString * cityId , NSString *area ,NSString *areaId))compltedBlock cancleBlock:(void(^)())cancelBlock;
//显示自定义单条，多条选择器
- (void)showMultiPickerViewWithData:(NSArray *)array withComponentCount:(int)componentCount withCompltedBlock:(void (^)(NSString *componentOneShow,NSString * componentOneBack,NSString *componentTwoShow,NSString * componentTwoBack,NSString *componentThreeShow,NSString * componentThreeBack))compltedBlock cancelBlock:(void (^)())cancelBlock;
//设置单条 显示的key、返回key
- (void)setMultiPickerViewComponentOneShowKeyName:(NSString *)showKeyName withBackKeyName:(NSString *)backNameKey;
//设置2条 显示的key、返回key
- (void)setMultiPickerViewComponentOneShowKeyName:(NSString *)oneShowKeyName withOneBackKeyName:(NSString *)OnebackNameKey withOneChildKey:(NSString *)oneChildKey withTwoShowKeyName:(NSString *)twoShowKeyName withTwoBackNameKeyName:(NSString *)TwobackNameKey;
//设置3条 显示的key、返回key
- (void)setMultiPickerViewComponentOneShowKeyName:(NSString *)oneShowKeyName
                               withOneBackKeyName:(NSString *)onebackNameKey
                                  withOneChildKey:(NSString *)oneChildKey
                               withTwoShowKeyName:(NSString *)twoShowKeyName
                           withTwoBackNameKeyName:(NSString *)twobackNameKey
                                  withTwoChildKey:(NSString *)twoChildKey
                             withThreeShowKeyName:(NSString *)threeShowKeyName
                         withThreeBackNameKeyName:(NSString *)threebackNameKey;


/*  设置Picker显示 最小-最大范围  默认范围为:1991-01-01 2300:12:31
 *  maxString 最大时间
 *  minString 最小时间
 *  dateStringBlock 选择日期回调
 */
- (void)showWithMaxDateString:(NSString *)maxString withMinDateString:(NSString *)minString didSeletedDateStringBlock:(void (^)(NSString *dateString))dateStringBlock;




#pragma topView 通用方法

//设置top leftbutton、rightButton、titleLabel string
- (void)setPickViewTopWithLeftButtonString:(NSString  *)leftString withRightButtonString:(NSString *)rightString withTitleString:(NSString *)titleString;
//设置top leftbutton、rightButton、titleLabel 颜色
- (void)setPickViewTopWithLeftButtonColor:(UIColor  *)leftColor withRightButtonColor:(UIColor *)rightColor withTitleColor:(UIColor *)titleColor withTopBgColor:(UIColor *)bgColor;


- (void)setPickViewWithTopHeight:(CGFloat)height;




@end
