//
//  MessageCell.h
//  AgencyCoreMobile_v1002
//
//  Created by Joy Tao on 3/19/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicMessageCell : UITableViewCell

@property (nonatomic , strong) UILabel * senderLabel;
@property (nonatomic , strong) UILabel * subjectLabel;
@property (nonatomic , strong) UILabel * messageLabel;
@property (nonatomic , strong) UILabel * dateLabel;

@property (nonatomic , strong) UIImageView * statusImageView;
@property (nonatomic , strong) UIImageView * attachedImageView;

@end
