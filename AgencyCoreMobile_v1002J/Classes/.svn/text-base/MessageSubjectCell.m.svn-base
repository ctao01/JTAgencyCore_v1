//
//  MessageSubjectCell.m
//  AgencyCoreMobile_v1002
//
//  Created by Joy Tao on 3/20/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "MessageSubjectCell.h"

@implementation MessageSubjectCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 2.0f, 80.0f, 44.0f)];
        self.titleLabel.textColor = [UIColor grayColor];
        self.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0f];

        
        self.subjectLabel = [[UILabel alloc]initWithFrame:CGRectMake(105.0f, 2.0f, 220.0f, 44.0f)];
        self.subjectLabel.textColor = [UIColor blackColor];
        self.subjectLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
        
        self.updatedLabel = [[UILabel alloc]initWithFrame:CGRectMake(105.0f, 36.0f, 220.0f, 20.0f)];
        self.updatedLabel.textColor = [UIColor grayColor];
        self.updatedLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0f];
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.subjectLabel];
        [self.contentView addSubview:self.updatedLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
