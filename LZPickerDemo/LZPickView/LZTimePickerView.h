//
//  LZTimePickerView.h
//  smart_small
//
//  Created by LZ on 2017/7/5.
//  Copyright © 2017年 LZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZPickTopView.h"

@interface LZTimePickerView : UIDatePicker

//确定
@property(nonatomic,copy)void (^LZPickerClickSureHandle)(NSDate *choseDate);
;
//取消
@property(nonatomic,copy)void (^LZPickerClickCancleHandle)();
;


@property(nonatomic,strong)LZPickTopView * topView;
- (void)showWithDatePickerMode:(UIDatePickerMode)mode compltedBlock:(void (^)(NSDate *choseDate))compltedBlock cancelBlock:(void (^)())cancelBlock;

//设置时间选择器 最大、最小、固定date
@property(nonatomic,strong)NSDate * maxDate, * minDate , * fixedValueDate;





@end
