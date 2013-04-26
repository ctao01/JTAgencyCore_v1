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
        
        CGRect innerRect;
        if (iPHONE_UI) innerRect = UIEdgeInsetsInsetRect(self.contentView.frame, UIEdgeInsetsMake(2.0f, 10.0f, 2.0f, 10.0f));
        else if (iPAD_UI) innerRect = UIEdgeInsetsInsetRect(self.contentView.frame, UIEdgeInsetsMake(5.0f, 10.0f, 2.0f, 10.0f));
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, innerRect.origin.y, 80.0f, 20.0f)];
//        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 2.0f, 80.0f, 44.0f)];
        self.titleLabel.textColor = [UIColor grayColor];
        if (iPHONE_UI)  self.titleLabel.font = ACFontDefault14;
        else if (iPAD_UI)   self.titleLabel.font = ACFontDefault16;
        
        self.subjectLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLabel.frame.origin.x + self.titleLabel.frame.size.width + 10.0f , innerRect.origin.y, innerRect.size.width, 20.0f)];
        self.subjectLabel.textColor = [UIColor blackColor];
        if (iPHONE_UI)  self.subjectLabel.font = ACFontDefault14;
        else if (iPAD_UI)   self.subjectLabel.font = ACFontDefault16;
        
//        self.updatedLabel = [[UILabel alloc]initWithFrame:CGRectMake(100.0f, 36.0f, 220.0f, 20.0f)];
        self.updatedLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.subjectLabel.frame.origin.x, self.subjectLabel.frame.origin.y + self.subjectLabel.frame.size.height, self.subjectLabel.frame.size.width, 20.0f)];
        self.updatedLabel.textColor = [UIColor grayColor];
        if (iPHONE_UI)  self.updatedLabel.font = ACFontDefault14;
        else if (iPAD_UI)   self.updatedLabel.font = ACFontDefault16;
        
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
