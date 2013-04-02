//
//  Account2ViewController.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 3/29/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "Account2ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ActivityCell.h"

@interface Account2ViewController ()

@end

@implementation Account2ViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundView = nil;
	self.tableView.backgroundColor = [UIColor colorWithRed:62.0f/255.0f green:62.0f/255.0f blue:60.0f/255.0f alpha:1.0f];
    
    CGRect rectProfile = CGRectMake(0.0f, 0.0f, self.tableView.frame.size.width, 215.0f);
    self.profilview = [[ProfileView alloc]initWithFrame:UIEdgeInsetsInsetRect(rectProfile, UIEdgeInsetsMake(20.0f, 10.0f, 20.0f, 10.0f)) style:UITableViewStylePlain];
    self.profilview.scrollEnabled = NO;
    
    self.profilview.layer.cornerRadius = 3.0f;
    self.profilview.layer.masksToBounds = YES;
    
    UIView * svProfile = [[UIView alloc]initWithFrame:rectProfile];
    svProfile.layer.shadowRadius = 8.0f;
    svProfile.layer.shadowOpacity = 0.8f;
    svProfile.layer.shadowColor = [[UIColor blackColor]CGColor];
    svProfile.layer.shadowOffset = CGSizeMake(0.0f, 4.0f);
    [svProfile addSubview:self.profilview];
    
    self.tableView.tableHeaderView = svProfile;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Data Source

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"ActivityCell";
    ActivityCell * cell = [self.tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
        cell = (ActivityCell*)[[ActivityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.textLabel.text = @"Activity Cell";
    
    return cell;
}

#pragma mark - UITableView Delegate

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) return 32.0f;
    else return 0;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 32.0f)];
        UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, self.tableView.bounds.size.width - 20.0f, 32.0f)];
        headerLabel.textColor = [UIColor whiteColor];
        headerLabel.font = [UIFont systemFontOfSize:16.0f];
        headerLabel.text = @"Recent Activities";
        headerLabel.backgroundColor = [UIColor clearColor];
        [headerView addSubview:headerLabel];
        
        return headerView;
    }
    else return nil;
}

@end
