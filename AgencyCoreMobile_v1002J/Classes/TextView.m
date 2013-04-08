//
//  TextView.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/8/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "TextView.h"

@implementation TextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UILabel * descLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 10.0f, frame.size.width , 20.0f)];
        descLabel.font = ACFontDefault16;
        descLabel.text = @"Enter a Visit Comment below:";
        
        UITextView * commentsField = [[UITextView alloc]initWithFrame:CGRectMake(12.0f, 41.0f, 296.0f, 100.0f)];
        commentsField.scrollEnabled = YES;
        
        [self addSubview:descLabel];
        [self addSubview:commentsField];
        
    }
    return self;
}

//- (void) addSeperatorLineFromPoint:(CGPoint)start toPoint:(CGPoint)end
//{
//   
//    [[UIColor blackColor]setStroke];
//    [path stroke];
//}

- (void) drawRect:(CGRect)rect
{
    UIBezierPath * path = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(40.0f, 10.0f, 5.0f, 10.0f))];
    
    UIBezierPath * seperatorLine = [UIBezierPath bezierPath];
    [seperatorLine moveToPoint:CGPointMake(rect.origin.x, rect.origin.y)];
    [seperatorLine addLineToPoint:CGPointMake(rect.origin.x + rect.size.width, rect.origin.y)];
    
    [[UIColor blackColor]setStroke];
    [path stroke];
    [seperatorLine stroke];
}

@end
