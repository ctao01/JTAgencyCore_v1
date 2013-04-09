//
//  MessageCell.m
//  AgencyCoreMobile_v1002
//
//  Created by Joy Tao on 3/19/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "BasicMessageCell.h"

@implementation BasicMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect innerRect = UIEdgeInsetsInsetRect(self.contentView.frame, UIEdgeInsetsMake(10.0f, 20.0f, 10.0f, 20.0f));
        if ([reuseIdentifier isEqualToString:@"iPhone_Portrait_Cell"])
            self.senderLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, innerRect.origin.y, 180.0f, 20.0f)];
        else if ([reuseIdentifier isEqualToString:@"iPhone_Landscape_Cell"])
            self.senderLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, innerRect.origin.y, 340.0f, 20.0f)];
        else if ([reuseIdentifier isEqualToString:@"iPad_Portrait_Cell"])
            self.senderLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, innerRect.origin.y, 620, 20.0f)];
        else if ([reuseIdentifier isEqualToString:@"iPad_Landscape_Cell"])
            self.senderLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, innerRect.origin.y, 880.0f, 20.0f)];
        
        [self.senderLabel  setFont:ACFontDefaultBold16];
        [self.contentView addSubview:self.senderLabel];
        
        self.dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.senderLabel.frame.origin.x + self.senderLabel.frame.size.width -10.0f, innerRect.origin.y, 120.0f, 20.0f)];
//        self.dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 20.0f)];

        [self.dateLabel  setFont:ACFontDefaultBold14];
        [self.dateLabel setTextColor:ACColorTextRed];
        [self.dateLabel setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:self.dateLabel];
        
        self.subjectLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, self.senderLabel.frame.origin.y + self.senderLabel.frame.size.height, self.senderLabel.frame.size.width, 20.0f)];
//        self.subjectLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.senderLabel.frame.size.width, 20.0f)];

        [self.subjectLabel  setFont:ACFontDefault14];
        [self.contentView addSubview:self.subjectLabel];
        
        self.messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, self.subjectLabel.frame.origin.y + 16 , innerRect.size.width, 40.0f)];
//        self.messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.senderLabel.frame.size.width, 40.0f)];

        [self.messageLabel  setFont:ACFontDefault12];
        [self.messageLabel setTextColor:[UIColor darkGrayColor]];
        self.messageLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.messageLabel.numberOfLines = 0;
        [self.contentView addSubview:self.messageLabel];
        
        for (UIView * labels in self.contentView.subviews)
            labels.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
