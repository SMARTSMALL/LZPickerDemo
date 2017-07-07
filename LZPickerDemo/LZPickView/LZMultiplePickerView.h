//
//  LZMultiplePickerView.h
//  smart_small
//
//  Created by LZ on 2017/7/6.
//  Copyright © 2017年 LZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZPickTopView.h"
#import "LZPickViewDefine.h"

@interface LZMultiplePickerView : UIPickerView

//类方法
+ (instancetype)initMultiplePicker;
//确定Block
@property(nonatomic,copy)void (^LZPickerClickSureHandle)(NSString *componentOneShow,NSString * componentOneBack,NSString *componentTwoShow,NSString * componentTwoBack,NSString *componentThreeShow,NSString * componentThreeBack);
;
//取消Block
@property(nonatomic,copy)void (^LZPickerClickCancleHandle)();
;
@property(nonatomic,strong)LZPickTopView * topView;
@property (nonatomic,assign) int  componentCount;
//单个 显示key字段  返回key字段
@property(nonatomic,copy)NSString * componentOneShowKey, * componentOneBackKey;
//多个中  componentOneChildArray: 第一列下的子集key
@property(nonatomic,strong)NSString * componentOneChildKey;
//多个钟 第二列key字段、 返回key 字段
@property(nonatomic,copy)NSString * componentTwoShowKey, * componentTwoBackKey;
//多个中  componentOneChildArray: 第二列下的子集key
@property(nonatomic,strong)NSString * componentTwoChildKey;
//多个钟 第三列key字段、 返回key 字段
@property(nonatomic,copy)NSString * componentThreeShowKey, * componentThreeBackKey;
/*
 * data 数据源
 * componentCount 显示列数
 * compltedBlock 成功回掉函数
 * cancelBlock 取消回掉函数
 */
- (void)showWithData:(NSArray *)data
  withComponentCount:(int)componentCount
   withCompltedBlock:(void (^)(NSString *componentOneShow,NSString * componentOneBack,NSString *componentTwoShow,NSString * componentTwoBack,NSString *componentThreeShow,NSString * componentThreeBack))compltedBlock
         cancelBlock:(void (^)())cancelBlock;



@end
