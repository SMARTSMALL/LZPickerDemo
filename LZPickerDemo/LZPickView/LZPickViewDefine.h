
//
//  LZPickViewDefine.h
//  smart_small
//
//  Created by LZ on 2017/7/5.
//  Copyright © 2017年 LZ. All rights reserved.
//

#ifndef LZPickViewDefine_h
#define LZPickViewDefine_h

//屏幕宽度
#define kPICKVIEW_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
//屏幕高度
#define kPICKVIEW_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
//字体大小
#define PickFont(font)  [UIFont systemFontOfSize:font]
//字体大小
#define PickFontColor(color)  [UIColor color]
//获取路径
#define BundlePath(plistName) [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"]
// NSString * goldPath = [[NSBundle mainBundle] pathForResource:@"goldeneyeAddress" ofType:@"plist"];
//提示框

#define AlertShow(msg) [[[UIAlertView alloc]initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil] show];


#endif /* LZPickViewDefine_h */
