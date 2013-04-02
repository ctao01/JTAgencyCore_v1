//
//  ActivityCell.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 3/29/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "ActivityCell.h"

@implementation ActivityCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {        
        self.backgroundView = [[UIImageView alloc]init];
        self.textLabel.backgroundColor = [UIColor clearColor];
        UIImage * backgroundImage = [[UIImage imageNamed:@"bg_item_cell_x80"] resizableImageWithCapInsets:UIEdgeInsetsMake(40.0f, 2.0f, 40.0f, 2.0f)];
        ((UIImageView*)self.backgroundView).image = backgroundImage;
        
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
