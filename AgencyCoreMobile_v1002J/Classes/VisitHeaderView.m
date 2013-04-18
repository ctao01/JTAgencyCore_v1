//
//  VisitHeaderView.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/8/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "VisitHeaderView.h"

@interface VisitHeaderView ()

@property (nonatomic , strong) UILabel * patientLabel;
@property (nonatomic , strong) UILabel * taskLabel;
@property (nonatomic , strong) UILabel * statusLabel;
@property (nonatomic , strong) UILabel * dateLabel;

@end

@implementation VisitHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.patientLabel = [[UILabel alloc]init];
        self.patientLabel.backgroundColor = [UIColor clearColor];
        self.patientLabel.font = ACFontDefaultBold16;
        
        self.dateLabel = [[UILabel alloc]init];
        self.dateLabel.backgroundColor = [UIColor clearColor];
        self.dateLabel.font = ACFontDefaultBold14;
        self.dateLabel.textColor = ACColorRed;
        self.dateLabel.textAlignment = NSTextAlignmentRight;
        
        self.taskLabel = [[UILabel alloc]init];
        self.taskLabel.backgroundColor = [UIColor clearColor];
        self.taskLabel.font = ACFontDefault16;
        
        self.statusLabel = [[UILabel alloc]init];
        self.statusLabel.backgroundColor = [UIColor clearColor];
        self.statusLabel.font = ACFontDefault14;
        
        [self addSubview:self.patientLabel];
        [self addSubview:self.dateLabel];
        [self addSubview:self.taskLabel];
        [self addSubview:self.statusLabel];
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
    
    CGRect innerRect = UIEdgeInsetsInsetRect(self.frame, UIEdgeInsetsMake(10.0f, horizontalOffset, 10.0f, horizontalOffset));
    [self.patientLabel setFrame:CGRectMake(innerRect.origin.x, innerRect.origin.y, innerRect.size.width, 44.0f)];
    [self.dateLabel setFrame:CGRectMake(innerRect.origin.x + innerRect.size.width - 120.0f, innerRect.origin.y, 120.0f, 44.0f)];
    [self.taskLabel setFrame:CGRectMake(innerRect.origin.x, self.patientLabel.frame.origin.y + 30.0f, innerRect.size.width, 24.0f)];
    [self.statusLabel setFrame:CGRectMake(innerRect.origin.x, self.taskLabel.frame.origin.y + 20.0f, innerRect.size.width, 24.0f)];
    
    self.patientLabel.text = @"Tom Hanks";
    self.taskLabel.text = @"HHA Visit";
    self.statusLabel.text = @"Upcoming";
    [self.statusLabel setTextColor:ACColorTaskScheduledBlue];

    self.dateLabel.text = [NSString shortDateStyleStringFromDate:[NSDate date]];
}

@end
