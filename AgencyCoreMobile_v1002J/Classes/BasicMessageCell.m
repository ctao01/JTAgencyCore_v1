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
    innerRect = UIEdgeInsetsInsetRect(self.contentView.frame, UIEdgeInsetsMake(10.0f, 30.0f, 10.0f, 20.0f));
        if (iPAD_UI)
        {
            self.statusImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 20.0f, 20.0f)];
            self.statusImageView.center = CGPointMake(self.statusImageView.center.x, 55.0f);
        }
        else if (iPHONE_UI)
        {
            self.statusImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 16.0f, 16.0f)];
            self.statusImageView.center = CGPointMake(self.statusImageView.center.x, 45.0f);
        }
        self.statusImageView.frame = CGRectOffset(self.statusImageView.frame, 5.0f, 0.0f);
        [self.contentView addSubview:self.statusImageView];

        
        float labelHeight;
        if (iPHONE_UI) labelHeight = 20;
        else if (iPAD_UI) labelHeight = 24;
        else labelHeight = 0.0f;
        if ([reuseIdentifier isEqualToString:@"iPhone_Portrait_Cell"] || [reuseIdentifier isEqualToString:@"iPad_Portrait_Cell"] )
            self.senderLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, innerRect.origin.y, width(Bounds_Screen) - 80.0f, labelHeight)];
        else if ([reuseIdentifier isEqualToString:@"iPhone_Landscape_Cell"] || [reuseIdentifier isEqualToString:@"iPad_Landscape_Cell"])
            self.senderLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, innerRect.origin.y, height(Bounds_Screen) - 80.0f, labelHeight)];
        if (iPHONE_UI)[self.senderLabel  setFont:ACFontDefaultBold16];
        else if (iPAD_UI) [self.senderLabel setFont:ACFontDefaultBold18];
        [self.contentView addSubview:self.senderLabel];
        
        
        // Date Label:
        if (UserInterface_Portrait) self.dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(width(Bounds_Screen) - 155.0f, origin_y(self.senderLabel.frame), 120.0f, 20.0f)];
        else self.dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(height(Bounds_Screen) - 155.0f, origin_y(self.senderLabel.frame), 120.0f, 20.0f)];
        if (iPHONE_UI) [self.dateLabel setFont:ACFontDefaultBold14];
        else if (iPAD_UI) [self.dateLabel setFont:ACFontDefaultBold16];
        [self.dateLabel setTextColor:ACColorRed];
        [self.dateLabel setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:self.dateLabel];
        
        
        // Subject Label
        self.subjectLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, self.senderLabel.frame.origin.y + self.senderLabel.frame.size.height, self.senderLabel.frame.size.width, 20.0f)];
        if (iPHONE_UI) [self.subjectLabel  setFont:ACFontDefault14];
        else if (iPAD_UI) [self.subjectLabel setFont:ACFontDefault16];
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
