//
//  AxxessContactCell.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 5/14/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "AxxessContactCell.h"
#define AC_CELL_HEIGHT 90.0f
#define AC_CELL_VERTICAL_OFFSET AC_CELL_HEIGHT / 4.0f
#define AC_CELL_BUTTON_SIZE AC_CELL_VERTICAL_OFFSET * 3

@implementation AxxessContactCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat contentWidth;
        if (UserInterface_Portrait) contentWidth = width(Bounds_Screen);
        else  contentWidth = height(Bounds_Screen);

        CGFloat horizontalOffset = contentWidth / 13.0f;
        
        UIButton * phoneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        phoneButton.frame = CGRectMake(horizontalOffset, AC_CELL_VERTICAL_OFFSET * 0.5f , AC_CELL_BUTTON_SIZE, AC_CELL_BUTTON_SIZE);
        
        UIButton * emailButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        emailButton.frame = phoneButton.frame;
        emailButton.frame = CGRectOffset(emailButton.frame, horizontalOffset * 4.0f, 0.0f);
        
        UIButton * addressButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        addressButton.frame = emailButton.frame;
        addressButton.frame = CGRectOffset(addressButton.frame, horizontalOffset * 4.0f, 0.0f);
        
        [self.contentView addSubview:phoneButton];
        [self.contentView addSubview:emailButton];
        [self.contentView addSubview:addressButton];

        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
