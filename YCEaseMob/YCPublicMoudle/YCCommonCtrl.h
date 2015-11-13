//
//  YCCommonCtrl.h
//  HuanXin
//
//  Created by 袁灿 on 15/10/20.
//  Copyright © 2015年 yuancan. All rights reserved.
//  快速创建常用的控件

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YCCommonCtrl : NSObject

//创建UILabel
+ (UILabel *)commonLableWithFrame:(CGRect)frame
                             text:(NSString *)text
                            color:(UIColor *)color
                             font:(UIFont *)font
                    textAlignment:(NSTextAlignment)textAlignment;

//创建UITextField
+ (UITextField *)commonTextFieldWithFrame:(CGRect)frame
                              placeholder:(NSString *)placeholder
                                    color:(UIColor *)color
                                     font:(UIFont *)font
                          secureTextEntry:(BOOL)secureTextEntry
                                 delegate:(id)delegate;

//创建UITextView
+ (UITextView *)commonTextViewWithFrame:(CGRect)frame
                                   text:(NSString *)text
                                  color:(UIColor *)color
                                   font:(UIFont *)font
                          textAlignment:(NSTextAlignment)textAlignment;

//创建UIButton
+ (UIButton *)commonButtonWithFrame:(CGRect)frame
                              title:(NSString *)title
                              color:(UIColor *)color
                               font:(UIFont *)font
                    backgroundImage:(UIImage *)backgroundImage
                             target:(id)target
                             action:(SEL)action;

//创建图片
+ (UIImageView*)commonImageViewWithFrame:(CGRect)frame image:(UIImage*)image;

//创建背景图片
+ (UIImage*)imageWithColor:(UIColor*)color;


//创建UIView
+ (UIView *)commonViewWithFrame:(CGRect)frame backgroundColor:(UIColor *)color;


//设置边框
+ (UIView *)setViewBorderWithView:(UIView *)view
                      borderColor:(UIColor *)color
                      borderWidth:(float)width
                     cornerRadius:(float)radius;

//创建UIAlterController
+ (UIAlertController *)commonAlterControllerWithTitle:(NSString *)title message:(NSString *)message;
@end
