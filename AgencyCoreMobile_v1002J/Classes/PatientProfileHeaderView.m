//
//  PatientProfileHeaderView.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 5/1/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "PatientProfileHeaderView.h"
#import "PatientProfileViewController.h"
#define RADIUS 8.0f
#define UPPER_OTTER_BOUND 150.0f
@interface PatientProfileHeaderView()
@property (nonatomic , strong) UIImageView * patientImage;
@property (nonatomic , strong) UILabel * nameLabel;
@property (nonatomic , strong) UILabel * MRLabel;
@property (nonatomic , strong) UILabel * DOBLabel;
@property (nonatomic , strong) UILabel * SOCLabel;

@property (nonatomic , strong) UILabel * iNameLabel;
@property (nonatomic , strong) UILabel * iIDLabel;
@end

@implementation PatientProfileHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect imageRect;
        if (iPHONE_UI)
        {
            imageRect = UIEdgeInsetsInsetRect(frame, UIEdgeInsetsMake(15.0f, 15.0f, 45.0f, 0.0f));
            imageRect.size.height = 60.0f;
            imageRect.size.width = 60.0f;
        }
        else
        {
            imageRect = UIEdgeInsetsInsetRect(frame, UIEdgeInsetsMake(15.0f, 15.0f, 45.0f, 0.0f));
            imageRect.size.height = 90.0f;
            imageRect.size.width = 90.0f;
        }
        [self addThumbImageFromRect:imageRect];
        
        
    }
    return self;
}

- (void) addUpperSubviewsFromRect:(CGRect)rect
{
    CGRect nameFrame = CGRectMake(origin_x(rect), origin_y(rect), width(rect), height(rect)/3);
    self.nameLabel = [[UILabel alloc]initWithFrame:UIEdgeInsetsInsetRect(nameFrame, UIEdgeInsetsMake(5.0f, 5.0f, 0.0f, 2.0f))];
    self.nameLabel.text = @"Patient Name";
    self.nameLabel.backgroundColor = [UIColor clearColor];
    if (iPHONE_UI)  self.nameLabel.font = ACFontDefaultBold14;
    else if (iPAD_UI) self.nameLabel.font = ACFontDefaultBold16;
    [self addSubview:self.nameLabel];
    
    if (iPHONE_UI)
        self.MRLabel = [[UILabel alloc]initWithFrame:CGRectMake(origin_x(rect)+ 3.0f, origin_y(rect) + height(rect)/3 , width(self.nameLabel.frame), 24.0f)];
    else
        self.MRLabel = [[UILabel alloc]initWithFrame:CGRectMake(origin_x(rect)+ 3.0f, origin_y(rect) + height(rect)/3 , width(self.nameLabel.frame), 24.0f)];
    self.MRLabel.text = [NSString stringWithFormat:@"MR #:"];
    self.MRLabel.backgroundColor = [UIColor clearColor];
    if (iPHONE_UI)  self.MRLabel.font = ACFontDefault14;
    else if (iPAD_UI) self.MRLabel.font = ACFontDefault16;
    [self addSubview:self.MRLabel];
    
    self.DOBLabel = [[UILabel alloc]initWithFrame:CGRectMake(origin_x(rect)+ 3.0f, origin_y(self.MRLabel.frame) + self.MRLabel.font.pointSize + 2.0f, width(self.nameLabel.frame), 24.0f)];
    self.DOBLabel.text = [NSString stringWithFormat:@"Birthday:"];
    self.DOBLabel.backgroundColor = [UIColor clearColor];
    if (iPHONE_UI)  self.DOBLabel.font = ACFontDefault14;
    else if (iPAD_UI) self.DOBLabel.font = ACFontDefault16;
    [self addSubview:self.DOBLabel];
    
    self.SOCLabel = [[UILabel alloc]initWithFrame:CGRectMake(origin_x(rect)+ 3.0f, origin_y(self.DOBLabel.frame) + self.DOBLabel.font.pointSize + 2.0f, width(self.DOBLabel.frame), 24.0f)];
    self.SOCLabel.text = [NSString stringWithFormat:@"S.O.C.:"];
    self.SOCLabel.backgroundColor = [UIColor clearColor];
    if (iPHONE_UI)  self.SOCLabel.font = ACFontDefault14;
    else if (iPAD_UI) self.SOCLabel.font = ACFontDefault16;
    [self addSubview:self.SOCLabel];
}

- (void) addLowerSubviewsFromRect:(CGRect)lowerRect
{
    CGRect nameRect = CGRectMake(origin_x(lowerRect), origin_y(lowerRect), (origin_x(lowerRect) + width(lowerRect))/2, height(lowerRect));
    self.iNameLabel = [[UILabel alloc]initWithFrame:UIEdgeInsetsInsetRect(nameRect, UIEdgeInsetsMake(2.0f, 3.0f, 2.0f, 2.0f))];
    self.iNameLabel.backgroundColor = [UIColor clearColor];
    if (iPHONE_UI)  self.iNameLabel.font = ACFontDefault14;
    else if (iPAD_UI) self.iNameLabel.font = ACFontDefault16;
    self.iNameLabel.text = @"Insurance Name";
    [self addSubview:self.iNameLabel];
    
    CGRect idRect = CGRectMake((origin_x(lowerRect) + width(lowerRect))/2, origin_y(lowerRect), (origin_x(lowerRect) + width(lowerRect))/2, height(lowerRect));
    self.iIDLabel = [[UILabel alloc]initWithFrame:UIEdgeInsetsInsetRect(idRect, UIEdgeInsetsMake(2.0f, 3.0f, 2.0f, 2.0f))];
    self.iIDLabel.backgroundColor = [UIColor clearColor];
    if (iPHONE_UI)  self.iIDLabel.font = ACFontDefault14;
    else if (iPAD_UI) self.iIDLabel.font = ACFontDefault16;
    self.iIDLabel.text = @"Insurance ID";
    [self addSubview:self.iIDLabel];
}

- (void) addThumbImageFromRect:(CGRect)rect
{
    UIImage * placeholderImage;
    if (iPHONE_UI) placeholderImage = [UIImage imageNamed:@"icon_patient_iphone"];
    else placeholderImage = [UIImage imageNamed:@"icon_patient_ipad"];
    //    self.patientImage =[[UIImageView alloc]initWithFrame:rect];
    //    [self.patientImage setImage:placeholderImage];
    //
    //    self.patientImage.layer.cornerRadius = 6.0f;
    //    self.patientImage.layer.borderWidth = 2.0f;
    //    self.patientImage.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    //    [self addSubview:self.patientImage];
    self.patientButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.patientButton setFrame:rect];
    [self.patientButton setBackgroundImage:placeholderImage forState:UIControlStateNormal];
    
    PatientProfileViewController * vc = (PatientProfileViewController*)self.displayController;
    [self.patientButton addTarget:vc action:@selector(changePatientPhoto) forControlEvents:UIControlEventTouchUpInside];
    
    self.patientButton.layer.cornerRadius = 6.0f;
    self.patientButton.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.patientButton.layer.borderWidth = 2.0f;
    self.patientButton.clipsToBounds = YES;
    [self addSubview:self.patientButton];
}

- (void) layoutSubviews
{
    [super layoutSubviews];
}
- (void) drawRect:(CGRect)rect
{
    
    // Drawing Rect: (320 x 150)
    CGRect frame;
    if (iPHONE_UI)
    {
        frame = UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(15.0f, 10.0f, 15.0f, 10.0f));
        UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:RADIUS];
        [[UIColor whiteColor] setFill];
        [path fill];
        
        CGRect upperRightRect = UIEdgeInsetsInsetRect(frame, UIEdgeInsetsMake(0.0f, 90.0f, 30.0f, 0.0f));
        [self drawUpperVeriticalLine:upperRightRect];
        [self drawUpperHorizontalLine:upperRightRect];
        
        
        CGRect lowerRect = UIEdgeInsetsInsetRect(frame, UIEdgeInsetsMake(90.0f, 0.0f, 0.0f, 0.0f));
        [self drawLowerHorizontalLine:lowerRect];
        [self drawLowerVeriticalLine:lowerRect];
    }
    else if (iPAD_UI)
    {
        frame = UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(15.0f, 40.0f, 10.0f, 40.0f));
        UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:RADIUS];
        [[UIColor whiteColor] setFill];
        [path fill];
        
//        CGRect imageRect = UIEdgeInsetsInsetRect(frame, UIEdgeInsetsMake(15.0f, 15.0f, 45.0f, 0.0f));
//        imageRect.size.height = 90.0f;
//        imageRect.size.width = 90.0f;
//        [self drawThumbViewWithRect:imageRect];
        
        CGRect upperRightRect = UIEdgeInsetsInsetRect(frame, UIEdgeInsetsMake(0.0f, 120.0f, 34.0f, 0.0f));
        [self drawUpperVeriticalLine:upperRightRect];
        [self drawUpperHorizontalLine:upperRightRect];
        
        
        CGRect lowerRect = UIEdgeInsetsInsetRect(frame, UIEdgeInsetsMake(120.0f, 0.0f, 0.0f, 0.0f));
        [self drawLowerHorizontalLine:lowerRect];
        [self drawLowerVeriticalLine:lowerRect];
    }

}
//
- (void) drawThumbViewWithRect:(CGRect)rect
{
//    UIBezierPath * pathThumbImg = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:RADIUS];
//    [pathThumbImg setLineWidth:4.0f];
//    [[UIColor lightGrayColor] setStroke];
//    [pathThumbImg stroke];
//    [pathThumbImg fill];
    
    UIImage * placeholderImage;
    if (iPHONE_UI) placeholderImage = [UIImage imageNamed:@"icon_patient_iphone"];
    else placeholderImage = [UIImage imageNamed:@"icon_patient_ipad"];
//    self.patientImage =[[UIImageView alloc]initWithFrame:rect];
//    [self.patientImage setImage:placeholderImage];
//    
//    self.patientImage.layer.cornerRadius = 6.0f;
//    self.patientImage.layer.borderWidth = 2.0f;
//    self.patientImage.layer.borderColor = [[UIColor lightGrayColor] CGColor];
//    [self addSubview:self.patientImage];
    self.patientButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.patientButton setFrame:rect];
    [self.patientButton setBackgroundImage:placeholderImage forState:UIControlStateNormal];
    
    PatientProfileViewController * vc = (PatientProfileViewController*)self.displayController;
    [self.patientButton addTarget:vc action:@selector(changePatientPhoto) forControlEvents:UIControlEventTouchUpInside];

    self.patientButton.layer.cornerRadius = 6.0f;
    self.patientButton.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.patientButton.layer.borderWidth = 2.0f;
    self.patientButton.clipsToBounds = YES;
    [self addSubview:self.patientButton];
    
}


- (void) drawLowerHorizontalLine:(CGRect)lowerRect
{
    UIBezierPath * horizontal = [UIBezierPath bezierPath];
    [horizontal moveToPoint:lowerRect.origin];
    [horizontal addLineToPoint:CGPointMake(origin_x(lowerRect) + width(lowerRect), origin_y(lowerRect))];
    if (iPHONE_UI) [horizontal setLineWidth:0.5f];
    else [horizontal setLineWidth:1.0f];
    [[UIColor lightGrayColor] setStroke];
    [horizontal stroke];
    
    if (self.iNameLabel) [self.iNameLabel removeFromSuperview];
    if (self.iIDLabel) [self.iIDLabel removeFromSuperview];
    
    CGRect insuranceRect = CGRectMake(origin_x(lowerRect), origin_y(lowerRect), (origin_x(lowerRect) + width(lowerRect))/2, height(lowerRect));
    self.iNameLabel = [[UILabel alloc]initWithFrame:UIEdgeInsetsInsetRect(insuranceRect, UIEdgeInsetsMake(2.0f, 3.0f, 2.0f, 2.0f))];
    self.iNameLabel.backgroundColor = [UIColor clearColor];
    if (iPHONE_UI)  self.iNameLabel.font = ACFontDefault14;
    else if (iPAD_UI) self.iNameLabel.font = ACFontDefault16;
    self.iNameLabel.text = @"Insurance Name";
    [self addSubview:self.iNameLabel];
    
    CGRect idRect = CGRectMake((origin_x(lowerRect) + width(lowerRect))/2, origin_y(lowerRect), (origin_x(lowerRect) + width(lowerRect))/2, height(lowerRect));
    self.iIDLabel = [[UILabel alloc]initWithFrame:UIEdgeInsetsInsetRect(idRect, UIEdgeInsetsMake(2.0f, 3.0f, 2.0f, 2.0f))];
    self.iIDLabel.backgroundColor = [UIColor clearColor];
    if (iPHONE_UI)  self.iIDLabel.font = ACFontDefault14;
    else if (iPAD_UI) self.iIDLabel.font = ACFontDefault16;
    self.iIDLabel.text = @"Insurance ID";
    [self addSubview:self.iIDLabel];
}

- (void) drawLowerVeriticalLine:(CGRect)lowerRect
{
    UIBezierPath * line = [UIBezierPath bezierPath];
    [line moveToPoint:CGPointMake((origin_x(lowerRect) + width(lowerRect)) /2.0f, origin_y(lowerRect))];
    [line addLineToPoint:CGPointMake((origin_x(lowerRect) + width(lowerRect)) /2.0f, origin_y(lowerRect)+ height(lowerRect))];
    if (iPHONE_UI) [line setLineWidth:0.5f];
    else [line setLineWidth:1.0f];
    [[UIColor lightGrayColor] setStroke];
    [line stroke];

}

- (void) drawUpperVeriticalLine:(CGRect)rect
{
    UIBezierPath * line = [UIBezierPath bezierPath];
    [line moveToPoint:rect.origin];
    [line addLineToPoint:CGPointMake(origin_x(rect), origin_y(rect) + height(rect))];
    if (iPHONE_UI) [line setLineWidth:0.5f];
    else [line setLineWidth:1.0f];
    [[UIColor lightGrayColor] setStroke];
    [line stroke];
    
    if (self.MRLabel) [self.MRLabel removeFromSuperview];
    if (self.nameLabel) [self.nameLabel removeFromSuperview];
    if (self.DOBLabel) [self.DOBLabel removeFromSuperview];
    if (self.SOCLabel) [self.SOCLabel removeFromSuperview];
    
    CGRect nameFrame = CGRectMake(origin_x(rect), origin_y(rect), width(rect), height(rect)/3);
    self.nameLabel = [[UILabel alloc]initWithFrame:UIEdgeInsetsInsetRect(nameFrame, UIEdgeInsetsMake(5.0f, 5.0f, 0.0f, 2.0f))];
    self.nameLabel.text = @"Patient Name";
    self.nameLabel.backgroundColor = [UIColor clearColor];
    if (iPHONE_UI)  self.nameLabel.font = ACFontDefaultBold14;
    else if (iPAD_UI) self.nameLabel.font = ACFontDefaultBold16;
    [self addSubview:self.nameLabel];
    
    if (iPHONE_UI)
        self.MRLabel = [[UILabel alloc]initWithFrame:CGRectMake(origin_x(rect)+ 5.0f, origin_y(rect) + height(rect)/3 , width(self.nameLabel.frame), 24.0f)];
    else
        self.MRLabel = [[UILabel alloc]initWithFrame:CGRectMake(origin_x(rect)+ 5.0f, origin_y(rect) + height(rect)/3 , width(self.nameLabel.frame), 24.0f)];
    self.MRLabel.text = [NSString stringWithFormat:@"MR #:"];
    self.MRLabel.backgroundColor = [UIColor clearColor];
    if (iPHONE_UI)  self.MRLabel.font = ACFontDefault14;
    else if (iPAD_UI) self.MRLabel.font = ACFontDefault16;
    [self addSubview:self.MRLabel];
    
    self.DOBLabel = [[UILabel alloc]initWithFrame:CGRectMake(origin_x(rect)+ 5.0f, origin_y(self.MRLabel.frame) + self.MRLabel.font.pointSize + 2.0f, width(self.nameLabel.frame), 24.0f)];
    self.DOBLabel.text = [NSString stringWithFormat:@"Birthday:"];
    self.DOBLabel.backgroundColor = [UIColor clearColor];
    if (iPHONE_UI)  self.DOBLabel.font = ACFontDefault14;
    else if (iPAD_UI) self.DOBLabel.font = ACFontDefault16;
    [self addSubview:self.DOBLabel];
    
    self.SOCLabel = [[UILabel alloc]initWithFrame:CGRectMake(origin_x(rect)+ 5.0f, origin_y(self.DOBLabel.frame) + self.DOBLabel.font.pointSize + 2.0f, width(self.DOBLabel.frame), 24.0f)];
    self.SOCLabel.text = [NSString stringWithFormat:@"S.O.C.:"];
    self.SOCLabel.backgroundColor = [UIColor clearColor];
    if (iPHONE_UI)  self.SOCLabel.font = ACFontDefault14;
    else if (iPAD_UI) self.SOCLabel.font = ACFontDefault16;
    [self addSubview:self.SOCLabel];
    
}

- (void) drawUpperHorizontalLine:(CGRect)rect
{
    UIBezierPath * line = [UIBezierPath bezierPath];
    [line moveToPoint:CGPointMake(origin_x(rect), origin_y(rect) + height(rect)/3)];
    [line addLineToPoint:CGPointMake(origin_x(rect) + width(rect), origin_y(rect) + height(rect)/3)];
    if (iPHONE_UI) [line setLineWidth:0.5f];
    else [line setLineWidth:1.0f];
    [[UIColor lightGrayColor] setStroke];
    [line stroke];
    
    
}

@end
