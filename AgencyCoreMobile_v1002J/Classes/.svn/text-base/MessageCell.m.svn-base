//
//  MessageCell.m
//  AgencyCoreMobile_v1002
//
//  Created by Joy Tao on 3/19/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect innerRect = UIEdgeInsetsInsetRect(self.contentView.frame, UIEdgeInsetsMake(10.0f, 20.0f, 10.0f, 20.0f));
//        self.senderLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, innerRect.origin.y, innerRect.size.width - 120.0f, 20.0f)];
        if (iPHONE_UI) self.senderLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, innerRect.origin.y, 180.0f, 20.0f)];
        else if (iPAD_UI) self.senderLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, innerRect.origin.y, 880.0f, 20.0f)];
        
        [self.senderLabel  setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16.0f]];
        [self.contentView addSubview:self.senderLabel];
        
        self.dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.senderLabel.frame.origin.x + self.senderLabel.frame.size.width -10.0f, innerRect.origin.y, 120.0f, 20.0f)];
//        self.dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 20.0f)];

        [self.dateLabel  setFont:[UIFont fontWithName:@"Helvetica" size:16.0f]];
        [self.dateLabel setTextColor:[UIColor redColor]];
        [self.dateLabel setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:self.dateLabel];
        
        self.subjectLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, self.senderLabel.frame.origin.y + self.senderLabel.frame.size.height, self.senderLabel.frame.size.width, 20.0f)];
//        self.subjectLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.senderLabel.frame.size.width, 20.0f)];

        [self.subjectLabel  setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
        [self.contentView addSubview:self.subjectLabel];
        
        self.messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(innerRect.origin.x, self.subjectLabel.frame.origin.y + 18 , self.senderLabel.frame.size.width, 40.0f)];
//        self.messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.senderLabel.frame.size.width, 40.0f)];

        [self.messageLabel  setFont:[UIFont fontWithName:@"Helvetica" size:12.0f]];
        [self.messageLabel setTextColor:[UIColor darkGrayColor]];
        self.messageLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.messageLabel.numberOfLines = 0;
        [self.contentView addSubview:self.messageLabel];
    }
    return self;
}

//- (void) layoutSubviews
//{
//    [super layoutSubviews];    
//    self.senderLabel.frame = CGRectOffset(self.senderLabel.frame, self.contentView.frame.origin.x, self.contentView.frame.origin.y);
//    
////    self.dateLabel.frame = CGRectOffset(self.dateLabel.frame, innerRect.origin.x + innerRect.size.width - 120.0f,innerRect.origin.y);
//    self.subjectLabel.frame = CGRectOffset(self.subjectLabel.frame, self.frame.origin.x, self.senderLabel.frame.origin.y + self.senderLabel.frame.size.height);
//    self.messageLabel.frame = CGRectOffset(self.messageLabel.frame, self.frame.origin.x, self.subjectLabel.frame.origin.y + 18);
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
