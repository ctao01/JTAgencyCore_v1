//
//  UIImageView+Additions.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 5/6/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "UIImageView+Additions.h"

@implementation UIImageView (Additions)

+ (UIImageView *) attachmentImageViewWithRect:(CGRect)frame
{
    UIImageView * attachedImage = [[UIImageView alloc]initWithFrame:frame];
    attachedImage.image = [[UIImage imageNamed:@"btn_blue"] resizableImageWithCapInsets:UIEdgeInsetsMake(0.0f, 6.0f, 1.0f, 6.0f)];

    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, width(attachedImage.frame), height(attachedImage.frame))];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = ACFontDefaultBold12;
    label.text = @"Attachment";
    [attachedImage addSubview:label];
    
    return attachedImage;
}

@end
