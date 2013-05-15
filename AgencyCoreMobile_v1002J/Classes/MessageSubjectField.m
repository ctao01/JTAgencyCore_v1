//
//  MessageSubjectField.m
//  AgencyCoreMobile_v1002
//
//  Created by Joy Tao on 3/20/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "MessageSubjectField.h"

@implementation MessageSubjectField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel * subjectLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, 1, 60, 25) ];
        [subjectLabel setText:@"Subject:"];
        [subjectLabel setFont:ACFontDefault14];
        [subjectLabel setTextColor:[UIColor grayColor]];
        [subjectLabel setTextAlignment:NSTextAlignmentRight];
        self.leftView = subjectLabel;
        self.leftViewMode = UITextFieldViewModeAlways;
        
//        UIButton * addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
//        addButton.frame = CGRectMake(0.0f, 0.0f, 24.0f, 24.0f);
//        self.rightView = addButton;
//        self.rightViewMode = UITextFieldViewModeAlways;

        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.inputView.frame = UIEdgeInsetsInsetRect(self.inputView.frame, UIEdgeInsetsMake(0.0f, 5.0f, 0.0f, 30.0f));
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void) drawRect:(CGRect)rect
{
    CGPoint start = CGPointMake(rect.origin.x, rect.origin.y + rect.size.height);
    CGPoint end = CGPointMake(rect.origin.x + rect.size.width, start.y);
    
    UIBezierPath * seperator = [UIBezierPath bezierPath];
    [seperator moveToPoint:start];
    [seperator addLineToPoint:end];
    [[UIColor colorWithWhite:0.2 alpha:1]setStroke];
    [seperator setLineWidth:1.0f];
    [seperator stroke];
}


@end
