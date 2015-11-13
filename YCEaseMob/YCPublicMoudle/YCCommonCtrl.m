//
//  YCCommonCtrl.m
//  HuanXin
//
//  Created by 袁灿 on 15/10/20.
//  Copyright © 2015年 yuancan. All rights reserved.
//

#import "YCCommonCtrl.h"

@implementation YCCommonCtrl

//创建UILabel
+ (UILabel *)commonLableWithFrame:(CGRect)frame
                             text:(NSString *)text
                            color:(UIColor *)color
                             font:(UIFont *)font
                    textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textColor = color;
    label.font = font;
    label.textAlignment = textAlignment;
    label.backgroundColor = [UIColor clearColor];
    
    return label;
}

//创建UITextField
+ (UITextField *)commonTextFieldWithFrame:(CGRect)frame
                              placeholder:(NSString *)placeholder
                                    color:(UIColor *)color
                                     font:(UIFont *)font
                          secureTextEntry:(BOOL)secureTextEntry
                                 delegate:(id)delegate
{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.placeholder = placeholder;
    textField.textColor = color;
    textField.font = font;
    textField.secureTextEntry = secureTextEntry;
    textField.delegate = delegate;
    
    return textField;
}

//创建UITextView
+ (UITextView *)commonTextViewWithFrame:(CGRect)frame
                                   text:(NSString *)text
                                  color:(UIColor *)color
                                   font:(UIFont *)font
                          textAlignment:(NSTextAlignment)textAlignment
{
    UITextView *textView = [[UITextView alloc] initWithFrame:frame];
    textView.text = text;
    textView.textColor = color;
    textView.font = font;
    textView.textAlignment = textAlignment;
    
    textView.backgroundColor = [UIColor clearColor];
    textView.editable = YES;
    textView.scrollEnabled = YES;
    textView.dataDetectorTypes = UIDataDetectorTypeLink;
    
    return textView;
}

//创建UIButton
+ (UIButton *)commonButtonWithFrame:(CGRect)frame
                              title:(NSString *)title
                              color:(UIColor *)color
                               font:(UIFont *)font
                    backgroundImage:(UIImage *)backgroundImage
                             target:(id)target
                             action:(SEL)action
{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn.titleLabel setFont:font];
    
    [btn setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

//创建图片
+ (UIImageView*)commonImageViewWithFrame:(CGRect)frame
                                    image:(UIImage*)image
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:frame];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.image = image;
    
    return imgView;
}

//创建背景图片
+ (UIImage*)imageWithColor:(UIColor*)color
{
    CGSize imageSize = CGSizeMake(1, 1);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

//创建UIView
+ (UIView *)commonViewWithFrame:(CGRect)frame backgroundColor:(UIColor *)color
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = color;
    return view;
}

//创建UIAlterController
+ (UIAlertController *)commonAlterControllerWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertController *alterController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
        
    UIAlertAction *alterAction = [UIAlertAction actionWithTitle:@"确定"
                                                          style:UIAlertActionStyleCancel
                                                        handler:nil];
    [alterController addAction:alterAction];
    return alterController;
}

//设置边框
+ (UIView *)setViewBorderWithView:(UIView *)view
                      borderColor:(UIColor *)color
                      borderWidth:(float)width
                     cornerRadius:(float)radius
{
    view.layer.borderColor = color.CGColor;
    view.layer.cornerRadius = radius;
    view.layer.borderWidth = width;
    view.layer.masksToBounds = YES;
    return view;
}

@end
