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
        CGRect innerRect ;
        if (iPAD_UI) innerRect = UIEdgeInsetsInsetRect(self.contentView.frame, UIEdgeInsetsMake(10.0f, 30.0f, 10.0f, 20.0f));
        else if (iPHONE_UI) innerRect = UIEdgeInsetsInsetRect(self.contentView.frame, UIEdgeInsetsMake(10.0f, 20.0f, 10.0f, 20.0f));

        float labelHeight;
        if (iPHONE_UI) labelHeight = 20;
        else if (iPAD_UI) labelHeight = 24;
        else labelHeight = 0.0f;
        if ([reuseIdentifier isEqualToString:@"iPhone_Portrait_Cell"])
            self.senderLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, innerRect.origin.y, 240.0f, labelHeight)];
        else if ([reuseIdentifier isEqualToString:@"iPhone_Landscape_Cell"])
        {
            CGRect screenSize = [[UIScreen mainScreen]bounds];
            if (screenSize.size.height >= 568.0f) self.senderLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, innerRect.origin.y, 480.0f, labelHeight)];
            else self.senderLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, innerRect.origin.y, 400.0f, labelHeight)];
        }
        else if ([reuseIdentifier isEqualToString:@"iPad_Portrait_Cell"])
            self.senderLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, innerRect.origin.y, 600.0f, labelHeight)];
        else if ([reuseIdentifier isEqualToString:@"iPad_Landscape_Cell"])
            self.senderLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, innerRect.origin.y, 860.0f, labelHeight)];
        
        if (iPHONE_UI)[self.senderLabel  setFont:ACFontDefaultBold16];
        else if (iPAD_UI) [self.senderLabel setFont:ACFontDefaultBold18];
        [self.contentView addSubview:self.senderLabel];
        
        
        // Date Label:

        if (iPHONE_UI)
        {
            self.dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(origin_x(self.senderLabel.frame) + width(self.senderLabel.frame) - 80.0f, origin_y(self.senderLabel.frame), 120.0f, 20.0f)];
            [self.dateLabel setFont:ACFontDefault16];
        }
        else if (iPAD_UI)
        {
            self.dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(origin_x(self.senderLabel.frame) + width(self.senderLabel.frame) - 20.0f, origin_y(self.senderLabel.frame), 120.0f, 20.0f)];
            [self.dateLabel setFont:ACFontDefault18];
        }

        [self.dateLabel setTextColor:ACColorRed];
        [self.dateLabel setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:self.dateLabel];
        
        
        // Subject Label
        self.subjectLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, self.senderLabel.frame.origin.y + self.senderLabel.frame.size.height, self.senderLabel.frame.size.width, 20.0f)];
        if (iPHONE_UI) [self.subjectLabel  setFont:ACFontDefault16];
        else if (iPAD_UI) [self.subjectLabel setFont:ACFontDefault18];
        [self.contentView addSubview:self.subjectLabel];
        
        self.messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, self.subjectLabel.frame.origin.y + labelHeight , self.senderLabel.frame.size.width, 40.0f)];
        
        // Message Label:
        if (iPHONE_UI) [self.messageLabel  setFont:ACFontDefault14];
        else if (iPAD_UI) [self.messageLabel setFont:ACFontDefault16];
        [self.messageLabel setTextColor:[UIColor darkGrayColor]];
        self.messageLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.messageLabel.numberOfLines = 0;
        [self.contentView addSubview:self.messageLabel];
        
        for (UIView * labels in self.contentView.subviews)
            labels.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end
