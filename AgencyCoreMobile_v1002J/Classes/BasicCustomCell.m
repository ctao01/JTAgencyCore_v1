//
//  AccountCell.m
//  AgencyCoreMobile_v1002
//
//  Created by Joy Tao on 3/18/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "BasicCustomCell.h"

@implementation BasicCustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 2.0f, 80.0f, 44.0f)];
        self.titleLabel.textColor = [UIColor grayColor];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        
        self.dataLabel = [[UILabel alloc]initWithFrame:CGRectMake(100.0f, 2.0f, 200.0f, 44.0f)];
        self.dataLabel.textColor = [UIColor blackColor];
        self.dataLabel.backgroundColor = [UIColor clearColor];

        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.dataLabel];
        
        for (UILabel * label in self.contentView.subviews)
            label.font = [UIFont fontWithName:@"Helvetica" size:14.0f];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
