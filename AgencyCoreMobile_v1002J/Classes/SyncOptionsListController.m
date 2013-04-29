//
//  SyncOptionsListController.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/29/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "SyncOptionsListController.h"

@interface SyncOptionsListController ()
@property (nonatomic , retain) NSIndexPath * selectedIndexPath;
@end

@implementation SyncOptionsListController

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSInteger row;
    NSInteger minute = [[NSUserDefaults standardUserDefaults]integerForKey:@"AutoSyncDuration"];
    if (minute)
    {
        NSLog(@"%i",minute);
        if (minute == 5) row = 0;
        else if (minute == 10) row = 1;
        else if (minute == 15) row = 2;
        else if (minute == 20) row = 3;
        else row = 4;
        self.selectedIndexPath = [NSIndexPath indexPathForRow:row inSection:0];
    }
    else
        self.selectedIndexPath = nil;
    [self.tableView reloadData];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    if ([self.selectedIndexPath isEqual:indexPath])
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    else
        cell.accessoryType = UITableViewCellAccessoryNone;
    
    if (indexPath.row == 0)
        cell.textLabel.text = @"5 Minutes";
    else if (indexPath.row == 1)
        cell.textLabel.text = @"10 Minutes (Default)";
    else if (indexPath.row == 2)
        cell.textLabel.text = @"15 Minutes";
    else if (indexPath.row == 3)
        cell.textLabel.text = @"20 Minutes";
    else if (indexPath.row == 4)
        cell.textLabel.text = @"30 Minutes";
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.selectedIndexPath)
    {
        UITableViewCell* uncheckCell =[tableView  cellForRowAtIndexPath:self.selectedIndexPath];
        uncheckCell.accessoryType =UITableViewCellAccessoryNone;
    }

    if([self.selectedIndexPath isEqual:indexPath])
    {
        self.selectedIndexPath = nil;
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"AutoSyncDuration"];

    }
    else
    {
        UITableViewCell* cell =[tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType =UITableViewCellAccessoryCheckmark;
        self.selectedIndexPath = indexPath;
        NSInteger minute;
        if (indexPath.row == 0) minute = 5;
        else if (indexPath.row == 1) minute = 10;
        else if (indexPath.row == 2) minute = 15;
        else if (indexPath.row == 3) minute = 20;
        else minute = 30;
        [[NSUserDefaults standardUserDefaults]setInteger:minute forKey:@"AutoSyncDuration"];

    }
    [[NSUserDefaults standardUserDefaults]synchronize];
//    [self.navigationController popViewControllerAnimated:YES];
}

@end
