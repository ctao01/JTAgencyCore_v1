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
        if (iPHONE_UI)  self.patientLabel.font = ACFontDefaultBold16;
        else self.patientLabel.font = ACFontDefaultBold18;
        
        self.dateLabel = [[UILabel alloc]init];
        self.dateLabel.backgroundColor = [UIColor clearColor];
        if (iPHONE_UI)  self.dateLabel.font = ACFontDefaultBold14;
        else  self.dateLabel.font = ACFontDefaultBold16;

        self.dateLabel.textColor = ACColorRed;
        self.dateLabel.textAlignment = NSTextAlignmentRight;
        
        self.taskLabel = [[UILabel alloc]init];
        self.taskLabel.backgroundColor = [UIColor clearColor];
        if (iPHONE_UI)  self.taskLabel.font = ACFontDefault16;
        else  self.taskLabel.font = ACFontDefault18;

        self.statusLabel = [[UILabel alloc]init];
        self.statusLabel.backgroundColor = [UIColor clearColor];
        if (iPHONE_UI)  self.statusLabel.font = ACFontDefault14;
        else self.statusLabel.font = ACFontDefault16;
        
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
    
    self.patientLabel.text = [self.taskObject objectForKey:@"patient"];
    self.taskLabel.text = [self.taskObject objectForKey:@"task_title"];
    self.statusLabel.text = [self.taskObject objectForKey:@"task_status"];
    if ([self.statusLabel.text isEqualToString:@"Missed"]) self.statusLabel.textColor = ACColorTaskMissedRed;
    else if ([self.statusLabel.text isEqualToString:@"Completed"]) self.statusLabel.textColor = ACColorTaskCompletedGreen;
    else self.statusLabel.textColor = ACColorTaskScheduledBlue;

    self.dateLabel.text = [self.taskObject objectForKey:@"schedule_date"];
}

@end
