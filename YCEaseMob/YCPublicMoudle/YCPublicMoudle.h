//
//  YCPublicMoudle.h
//  YCEaseMob
//
//  Created by 袁灿 on 15/10/29.
//  Copyright © 2015年 yuancan. All rights reserved.
//  公共模块头文件

#ifndef YCPublicMoudle_h
#define YCPublicMoudle_h

//与我自己框架有关的头文件
#import "YCCommonCtrl.h"
#import "YCUIView+FrameExpand.h"



//常用参数宏定义
#define SCREEN_WIDTH            [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT           [[UIScreen mainScreen] bounds].size.height



//字体宏定义
#define FONT(size)              [UIFont systemFontOfSize:(size)]

#define kFont_Title             FONT(17)
#define kFont_Button            FONT(18)

#define kFont_Large             FONT(14)
#define kFont_Middle            FONT(13)
#define kFont_Small             FONT(12)



//色值角度宏定义
#define COLOR(r,g,b,a)          ([UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)])
#define SHORTCOLOR(r)           ([UIColor colorWithRed:(r)/255.0f green:(r)/255.0f blue:(r)/255.0f alpha:(1)])

#define kColor_Black            SHORTCOLOR(0x33)
#define kColor_Gray             SHORTCOLOR(0x66)
#define kColor_LightGray        SHORTCOLOR(0x99)

#define kColor_White            SHORTCOLOR(0xff)
#define kColor_Blue             COLOR(0x30,0x90,0xe6,1)

#endif
