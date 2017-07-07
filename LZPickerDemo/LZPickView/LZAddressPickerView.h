//
//  LZAddressPickerView.h
//  smart_small
//
//  Created by LZ on 2017/7/5.
//  Copyright © 2017年 LZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZPickTopView.h"
#import "LZPickViewDefine.h"

@interface LZAddressPickerView : UIPickerView

//确定  choseAddress:全部地址 province:省 provinceID:省ID  city:市 cityID:市ID  area:区 areaID:区ID
@property(nonatomic,copy)void (^LZPickerClickSureHandle)(NSString *choseAddress,NSString *province , NSString *provinceID , NSString * city , NSString * cityID , NSString *area ,NSString *areaID);
;
//取消
@property(nonatomic,copy)void (^LZPickerClickCancleHandle)();
;

@property(nonatomic,strong)LZPickTopView * topView;

/**
 * 显示地址选择器
 * compltedBlock choseAddress:全部地址 province:省 provinceID:省ID  city:市 cityID:市ID  area:区 areaID:区ID
 * cancelBlock 取消
 */
- (void)showAddressPickerCompltedBlock:(void (^)(NSString *choseAddress,NSString *province , NSString *provinceID , NSString * city , NSString * cityId , NSString *area ,NSString *areaId))compltedBlock cancelBlock:(void (^)())cancelBlock;

@end
