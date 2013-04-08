//
//  TextViewCell.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/8/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "TextViewCell.h"

@interface TextViewCell ()
@property (nonatomic , strong) UILabel * descLabel;
@end

@implementation TextViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect innerRect = UIEdgeInsetsInsetRect(self.contentView.frame, UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f));
        self.descLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, innerRect.origin.y, innerRect.size.width - 20.0f, 20.0f)];
//        if ([reuseIdentifier isEqualToString:@"iPhone_Portrait_Cell"])
//            self.descLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, innerRect.origin.y, 200.0f, 20.0f)];
//        else if ([reuseIdentifier isEqualToString:@"iPhone_Landscape_Cell"])
//            self.descLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, innerRect.origin.y, 340.0f, 20.0f)];
//        else if ([reuseIdentifier isEqualToString:@"iPad_Portrait_Cell"])
//            self.descLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, innerRect.origin.y, 640.0f, 20.0f)];
//        else if ([reuseIdentifier isEqualToString:@"iPad_Landscape_Cell"])
//            self.descLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, innerRect.origin.y, 900.0f, 20.0f)];
        [self.descLabel setFont:ACFontDefaultBold16];
        self.descLabel.backgroundColor = [UIColor clearColor];
        self.descLabel.text = @"Enter a Visit Comment below:";
        
        self.tvComments = [[UITextView alloc]initWithFrame:CGRectMake(innerRect.origin.x, self.descLabel.frame.origin.y + self.descLabel.frame.size.height + 5.0f, innerRect.size.width - 20.0f, 200.0f)];
        self.tvComments.scrollEnabled = YES;
        
        [self.contentView addSubview:self.descLabel];
        [self.contentView addSubview:self.tvComments];

    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
