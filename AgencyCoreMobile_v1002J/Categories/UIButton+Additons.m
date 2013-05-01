//
//  UIButton+Additons.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 3/22/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "UIButton+Additons.h"

@implementation UIButton (Additons)

+ (UIButton*) grayStyleButtonWithTitle:(NSString*)title
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundImage:[[UIImage imageNamed:@"btn_Gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(0.0f, 6.0f, 0.0f, 6.0f)]forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (iPHONE_UI)  [button.titleLabel setFont:ACFontDefaultBold16];
    else    [button.titleLabel setFont:ACFontDefaultBold18];
    return button;
}

+ (UIButton*) redStyleButtonWithTitle:(NSString*)title
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundImage:[[UIImage imageNamed:@"btn_Red"] resizableImageWithCapInsets:UIEdgeInsetsMake(0.0f, 6.0f, 0.0f, 6.0f)]forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if (iPHONE_UI)[button.titleLabel setFont:ACFontDefaultBold14];
    else  [button.titleLabel setFont:ACFontDefaultBold16];

    return button;
}

@end
