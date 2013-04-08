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
        CGRect innerRect = UIEdgeInsetsInsetRect(frame, UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f));
        self.patientLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, innerRect.origin.y, innerRect.size.width, 44.0f)];
        self.patientLabel.backgroundColor = [UIColor clearColor];
        self.patientLabel.font = ACFontDefaultBold18;
        
        self.dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x + innerRect.size.width - 120.0f, innerRect.origin.y, 120.0f, 44.0f)];
        self.dateLabel.backgroundColor = [UIColor clearColor];
        self.dateLabel.font = ACFontDefaultBold14;
        self.dateLabel.textColor = ACColorTextRed;
        self.dateLabel.textAlignment = NSTextAlignmentRight;
        
        self.taskLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, self.patientLabel.frame.origin.y + 30.0f, innerRect.size.width, 24.0f)];
        self.taskLabel.backgroundColor = [UIColor clearColor];
        self.taskLabel.font = ACFontDefault16;
        
        self.statusLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, self.taskLabel.frame.origin.y + 20.0f, innerRect.size.width, 24.0f)];
        self.statusLabel.backgroundColor = [UIColor clearColor];
        self.statusLabel.font = ACFontDefault14;
        
        [self addSubview:self.patientLabel];
        [self addSubview:self.dateLabel];
        [self addSubview:self.taskLabel];
        [self addSubview:self.statusLabel];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withIdentifier:(NSString *)identifier
{
    self = [self initWithFrame:frame];
    return self;
}


- (void) layoutSubviews
{
    [super layoutSubviews];
    
    self.patientLabel.text = @"Tom Hanks";
    self.taskLabel.text = @"HHA Visit";
    self.statusLabel.text = @"Completed";
    self.dateLabel.text = [NSString shortDateStyleStringFromDate:[NSDate date]];
}

@end
