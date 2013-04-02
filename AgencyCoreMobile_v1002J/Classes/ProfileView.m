//
//  ProfileView.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 3/29/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "ProfileView.h"
#import "BasicCustomCell.h"

@implementation ProfileView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

#pragma mark - UITableView Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cell1ID = @"MyAccountCell";
    
    BasicCustomCell * accountCell = [tableView dequeueReusableCellWithIdentifier:cell1ID];
    if (accountCell == nil)
        accountCell = [[BasicCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell1ID];
    
    switch (indexPath.row) {
        case 0:
        {
            accountCell.titleLabel.text = @"Name";
            accountCell.dataLabel.text = @"Edem Jimbo";
            accountCell.dataLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
        }
            break;
        case 1:
        {
            accountCell.titleLabel.text = @"Agency";
            accountCell.dataLabel.text = @"Sunny Bobo Agnecy";
        }
            break;
        case 2:
        {
            accountCell.titleLabel.text = @"Address";
            accountCell.dataLabel.text = @"8035 E R L Thomton Fwy # 147 Dallas,Texas 76006";
            accountCell.dataLabel.lineBreakMode = NSLineBreakByWordWrapping;
            accountCell.dataLabel.numberOfLines = 0.0f;
        }
            break;
        case 3:
        {
            accountCell.titleLabel.text = @"Phone";
            accountCell.dataLabel.text = @"(214)660-4400";
        }
            break;
            
        default:
            break;
    }
    accountCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return accountCell;
}

#pragma mark - UITableView Delegate

//- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return @"Account Info";
//}

@end
