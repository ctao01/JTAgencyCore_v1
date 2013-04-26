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
        CGRect innerRect = UIEdgeInsetsInsetRect(self.contentView.frame, UIEdgeInsetsMake(10.0f, 40.0f, 10.0f, 20.0f));
        NSLog(@"rotate:%@",NSStringFromCGRect(innerRect));
        float labelHeight;
        if (iPHONE_UI) labelHeight = 20;
        else if (iPAD_UI) labelHeight = 24;
        else labelHeight = 0.0f;
        if ([reuseIdentifier isEqualToString:@"iPhone_Portrait_Cell"])
//            self.senderLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, innerRect.origin.y, 160.0f, labelHeight)];
            self.senderLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, innerRect.origin.y, 160.0f, labelHeight)];

        else if ([reuseIdentifier isEqualToString:@"iPhone_Landscape_Cell"])
        {
            CGRect screenSize = [[UIScreen mainScreen]bounds];
            if (screenSize.size.height >= 568.0f) self.senderLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, innerRect.origin.y, 380.0f, labelHeight)];
            else self.senderLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, innerRect.origin.y, 300.0f, labelHeight)];
        }
        else if ([reuseIdentifier isEqualToString:@"iPad_Portrait_Cell"])
            self.senderLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, innerRect.origin.y, 600.0f, labelHeight)];
        else if ([reuseIdentifier isEqualToString:@"iPad_Landscape_Cell"])
            self.senderLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, innerRect.origin.y, 860.0f, labelHeight)];
        
        if (iPHONE_UI)[self.senderLabel  setFont:ACFontDefaultBold16];
        else if (iPAD_UI) [self.senderLabel setFont:ACFontDefaultBold18];
        
        [self.contentView addSubview:self.senderLabel];
        
        self.dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(origin_x(self.senderLabel.frame) + width(self.senderLabel.frame) - 20.0f, origin_y(self.senderLabel.frame), 120.0f, 20.0f)];
//        self.dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 20.0f)];

        if (iPHONE_UI) [self.dateLabel  setFont:ACFontDefault16];
        else if (iPAD_UI) [self.dateLabel setFont:ACFontDefault18];

        [self.dateLabel setTextColor:ACColorRed];
        [self.dateLabel setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:self.dateLabel];
        
        self.subjectLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, self.senderLabel.frame.origin.y + self.senderLabel.frame.size.height, self.senderLabel.frame.size.width, 20.0f)];
//        self.subjectLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.senderLabel.frame.size.width, 20.0f)];

        if (iPHONE_UI) [self.subjectLabel  setFont:ACFontDefault14];
        else if (iPAD_UI) [self.subjectLabel setFont:ACFontDefault16];
        [self.contentView addSubview:self.subjectLabel];
        
        self.messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, self.subjectLabel.frame.origin.y + labelHeight , self.senderLabel.frame.size.width, 40.0f)];
//        self.messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.senderLabel.frame.size.width, 40.0f)];

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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
