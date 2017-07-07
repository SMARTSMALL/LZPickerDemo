//
//  LZCustomLimitDatePicker.h
//  smart_small
//
//  Created by LZ on 2017/7/7.
//  Copyright © 2017年 LZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZPickViewDefine.h"
#import "LZPickTopView.h"

@protocol LZCustomLimitDatePickerDelegate <NSObject>
@optional
//选中日期
-(void)didSelectedDateString:(NSString *)dateString;
//取消日期
-(void)cancelDatePicker;

@end

@interface LZCustomLimitDatePicker : UIView
//代理
@property (nonatomic ,weak)id<LZCustomLimitDatePickerDelegate>delegate;

@property(nonatomic,strong)LZPickTopView * topView;

//block回掉
@property(nonatomic,copy)void (^LimitDatePickerDidSelectedDateString)(NSString *dateString);

+ (instancetype)initCustomLimitDatePicker;
/*  设置Picker显示 最小-最大范围  默认范围为:1991-01-01 2300:12:31
 *  maxString 最大时间
 *  minString 最小时间
 *  dateStringBlock 选择日期回调
 */
- (void)showWithMaxDateString:(NSString *)maxString withMinDateString:(NSString *)minString didSeletedDateStringBlock:(void (^)(NSString *dateString))dateStringBlock;


@end
