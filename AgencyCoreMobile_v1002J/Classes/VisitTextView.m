//
//  TextView.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/8/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "VisitTextView.h"

@interface VisitTextView ()
{
    UILabel * descLabel;
}

@end

@implementation VisitTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        descLabel = [[UILabel alloc]init];
        if (iPHONE_UI)  descLabel.font = ACFontDefault16;
        else descLabel.font = ACFontDefault18;
        descLabel.text = @"Enter a Visit Comment below:";
        
        self.commentsField = [[UITextView alloc]init];
        self.commentsField.scrollEnabled = YES;
        self.commentsField.layer.cornerRadius = 1.0f;
        self.commentsField.layer.borderColor = [[UIColor grayColor] CGColor];
        self.commentsField.layer.borderWidth = 1.0f;
        if (iPHONE_UI) self.commentsField.font = ACFontDefault14;
        else self.commentsField.font = ACFontDefault16;
        
        
        [self addSubview:descLabel];
        [self addSubview:self.commentsField];
        
    }
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat horizontalOffset;
    if (iPHONE_UI) horizontalOffset = 10.0f;
    else if (iPAD_UI) horizontalOffset = 45.0f;
    else horizontalOffset = 0.0f;
    [descLabel setFrame:CGRectMake(horizontalOffset, 10.0f, self.frame.size.width , 20.0f)];
    
    CGFloat textviewHight;
    if (iPAD_UI && UserInterface_Portrait) textviewHight = 340.0f;
    else if (iPHONE_UI && UserInterface_Landscape) textviewHight = 80.0f;
    else textviewHight = 140.0f;
    [self.commentsField setFrame:CGRectMake(horizontalOffset + 2, 41.0f, self.frame.size.width - (horizontalOffset + 2) *2, textviewHight)];

}

- (void) drawRect:(CGRect)rect
{    
//    UIBezierPath * path = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(40.0f, 10.0f, 5.0f, 10.0f))];
    
    UIBezierPath * seperatorLine = [UIBezierPath bezierPath];
    [seperatorLine moveToPoint:CGPointMake(rect.origin.x, rect.origin.y)];
    [seperatorLine addLineToPoint:CGPointMake(rect.origin.x + rect.size.width, rect.origin.y)];
    
    [[UIColor blackColor]setStroke];
//    [path stroke];
    [seperatorLine stroke];
}

@end
