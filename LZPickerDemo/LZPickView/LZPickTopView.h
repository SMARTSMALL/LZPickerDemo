//
//  LZPickTopView.h
//  smart_small
//
//  Created by LZ on 2017/7/5.
//  Copyright © 2017年 LZ. All rights reserved.
//

#import <UIKit/UIKit.h>

//定义枚举类型
typedef enum {
    ClickTopViewTypeWithLeft,// 左边按钮点击
    ClickTopViewTypeWithRight//右边按钮点击
}ClickTopViewType;
@protocol LZPickTopViewDelegate <NSObject>
@optional
- (void)clickButtonHandel:(ClickTopViewType)type;
@end
@interface LZPickTopView : UIView
//类方法
+ (instancetype)pickTopView;
//取消标题 default 取消
@property(nonatomic,copy)NSString * leftTitle;
//确定标题 default 完成
@property(nonatomic,copy)NSString * rightTitle;
//提示标题 default 请选择
@property(nonatomic,copy)NSString * mainTitle;
//取消标题颜色  defaultColor [UIColor blackColor]
@property(nonatomic,strong)UIColor * leftTitleColor;
//确定标题颜色  defaultColor [UIColor blackColor]
@property(nonatomic,strong)UIColor * rightTitleColor;
//提示标题颜色  defaultColor [UIColor whiteColor]
@property(nonatomic,strong)UIColor * mainTitleColor;
//背景颜色  defaultColor [UIColor colorWithRed:0.090  green:0.463  blue:0.906 alpha:1]
@property(nonatomic,strong)UIColor * bgColor;
//top height defaultheight 40.0f
@property (nonatomic,assign) CGFloat topHeight;
//取消按钮字体大小 default 15.0f
@property (nonatomic,assign) CGFloat leftFontSize;
//确认按钮字体大小 default 15.0f
@property (nonatomic,assign) CGFloat rightFontSize;
//提示标题字体大小 default 15.0f
@property (nonatomic,assign) CGFloat titleFontSize;
//代理
@property (nonatomic,weak)id<LZPickTopViewDelegate>delegate;
//Block
@property(nonatomic,copy)void (^LZPickTopViewClickHandle)(ClickTopViewType type);


@end
