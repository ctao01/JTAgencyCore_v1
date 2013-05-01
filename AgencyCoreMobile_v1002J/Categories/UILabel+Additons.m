//
//  UILabel+Additons.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 3/25/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "UILabel+Additons.h"

@implementation UILabel (Additons)

+ (UILabel*) updatedLabelWithFrame:(CGRect)frame
{
    UILabel * updatedLabel = [[UILabel alloc]initWithFrame:frame];
    if(iPHONE_UI) [updatedLabel setFont:ACFontDefaultBold12];
    else  [updatedLabel setFont:ACFontDefaultBold14];
    [updatedLabel setTextColor:[UIColor whiteColor]];
    [updatedLabel setTextAlignment:NSTextAlignmentCenter];
    [updatedLabel setBackgroundColor:[UIColor clearColor]];
    
    return updatedLabel;
}

@end
