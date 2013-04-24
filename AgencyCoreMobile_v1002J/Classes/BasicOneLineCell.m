//
//  AccountCell.m
//  AgencyCoreMobile_v1002
//
//  Created by Joy Tao on 3/18/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "BasicOneLineCell.h"

@implementation BasicOneLineCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect innerRect = UIEdgeInsetsInsetRect(self.contentView.frame, UIEdgeInsetsMake(0.0f, 10.0f, 0.0f, 10.0f));
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, innerRect.origin.y, 100.0f, 44.0f)];
        self.titleLabel.textColor = [UIColor grayColor];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        
        if ([reuseIdentifier isEqualToString:@"iPhone_Portrait_Cell"])
            self.dataLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLabel.frame.origin.x + self.titleLabel.frame.size.width -10.0f, innerRect.origin.y, 200.0f, 44.0f)];
        else if ([reuseIdentifier isEqualToString:@"iPhone_Landscape_Cell"])
            self.dataLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLabel.frame.origin.x + self.titleLabel.frame.size.width -10.0f, innerRect.origin.y, 460.0f, 44.0f)];
        else if ([reuseIdentifier isEqualToString:@"iPad_Portrait_Cell"])
            self.dataLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLabel.frame.origin.x + self.titleLabel.frame.size.width -10.0f, innerRect.origin.y, 600, 44.0f)];
        else if ([reuseIdentifier isEqualToString:@"iPad_Landscape_Cell"])
            self.dataLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLabel.frame.origin.x + self.titleLabel.frame.size.width -10.0f, innerRect.origin.y, 900, 44.0f)];
        else
            self.dataLabel = [[UILabel alloc]initWithFrame:CGRectMake(100.0f, 2.0f, 200.0f, 44.0f)];

        self.dataLabel.textColor = [UIColor blackColor];
        self.dataLabel.backgroundColor = [UIColor clearColor];
//        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 2.0f, 80.0f, 44.0f)];
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.dataLabel];
        
        for (UILabel * label in self.contentView.subviews)
            label.font = ACFontDefault16;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
