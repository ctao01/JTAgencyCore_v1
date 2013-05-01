//
//  BasicTwoLinesCell.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/5/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "BasicTwoLinesCell.h"

@implementation BasicTwoLinesCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGRect innerRect = UIEdgeInsetsInsetRect(self.contentView.frame, UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f));
        if ([reuseIdentifier isEqualToString:@"iPhone_Portrait_Cell"])
            self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, innerRect.origin.y, 180.0f, 20.0f)];
        else if ([reuseIdentifier isEqualToString:@"iPhone_Landscape_Cell"])
        {
            CGRect screenSize = [[UIScreen mainScreen]bounds];
            if (screenSize.size.height >= 568.0f) self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, innerRect.origin.y, 420.0f, 20.0f)];
            else self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, innerRect.origin.y, 340.0f, 20.0f)];
        }
        else if ([reuseIdentifier isEqualToString:@"iPad_Portrait_Cell"])
            self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, innerRect.origin.y, 620.0f, 20.0f)];
        else if ([reuseIdentifier isEqualToString:@"iPad_Landscape_Cell"])
            self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, innerRect.origin.y, 880.0f, 20.0f)];
        if (iPHONE_UI)  [self.titleLabel setFont:ACFontDefaultBold16];
        else if (iPAD_UI)   [self.titleLabel setFont:ACFontDefaultBold18];
        self.dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLabel.frame.origin.x + self.titleLabel.frame.size.width - 30.0f, innerRect.origin.y, 120.0f, 20.0f)];
        if (iPHONE_UI)  [self.dateLabel setFont:ACFontDefaultBold14];
        else if (iPAD_UI)  [self.dateLabel setFont:ACFontDefaultBold16];

        [self.dateLabel setTextColor:ACColorRed];
        [self.dateLabel setTextAlignment:NSTextAlignmentRight];
        
        self.taskLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLabel.frame.origin.x , self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height , self.titleLabel.frame.size.width, 20.0f)];
        if (iPHONE_UI)  [self.taskLabel setFont:ACFontDefaultBold14];
        else if (iPAD_UI)  [self.taskLabel setFont:ACFontDefaultBold16];
        [self.taskLabel setTextColor:[UIColor grayColor]];
        
        self.statusLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.dateLabel.frame.origin.x, self.taskLabel.frame.origin.y, 120.0f, 20.0f)];
        if (iPHONE_UI)  [self.statusLabel setFont:ACFontDefaultBold14];
        else if (iPAD_UI)  [self.statusLabel setFont:ACFontDefaultBold16];
        [self.statusLabel setTextAlignment:NSTextAlignmentRight];

        [self.accessoryView setFrame:CGRectMake(self.contentView.frame.size.width - 32.0f , self.taskLabel.frame.origin.y, 32.0f, 32.0f)];
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.dateLabel];
        [self.contentView addSubview:self.taskLabel];
        [self.contentView addSubview:self.statusLabel];
    }
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    NSString * taskStatus = self.statusLabel.text;
    if ([taskStatus isEqualToString:@"Upcoming"])
        [self.statusLabel setTextColor:ACColorTaskScheduledBlue];
    else if ([taskStatus isEqualToString:@"Completed"])
        [self.statusLabel setTextColor:ACColorTaskCompletedGreen];
    else if ([taskStatus isEqualToString:@"Missed"])
        [self.statusLabel setTextColor:ACColorTaskMissedRed];
    
}

@end
