//
//  CleanOptionsListController.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/29/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "CleanOptionsListController.h"

@interface CleanOptionsListController ()
@property (nonatomic , retain) NSIndexPath * selectedIndexPath;

@end

@implementation CleanOptionsListController

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSInteger row;
    NSInteger days = [[NSUserDefaults standardUserDefaults]integerForKey:@"CleanUpStorageFreq"];
    if (days)
    {
        if (days == 30) row = 0;
        else if (days == 60) row = 1;
        else if (days == 90) row = 2;
        else if (days == 120) row = 3;
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
    self.selectedIndexPath = [NSIndexPath indexPathForRow:2 inSection:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        cell.textLabel.text = @"Every 30 Days";
    else if (indexPath.row == 1)
        cell.textLabel.text = @"Every 60 Days";
    else if (indexPath.row == 2)
        cell.textLabel.text = @"Every 90 Days (Default)";
    else if (indexPath.row == 3)
        cell.textLabel.text = @"Every 120 Days";
    else if (indexPath.row == 4)
        cell.textLabel.text = @"Every 180 Days";
    
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
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"CleanUpStorageFreq"];
        
    }
    else
    {
        UITableViewCell* cell =[tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType =UITableViewCellAccessoryCheckmark;
        self.selectedIndexPath = indexPath;
        NSInteger minute;
        if (indexPath.row == 0) minute = 30;
        else if (indexPath.row == 1) minute = 60;
        else if (indexPath.row == 2) minute = 90;
        else if (indexPath.row == 3) minute = 120;
        else minute = 180;
        [[NSUserDefaults standardUserDefaults]setInteger:minute forKey:@"CleanUpStorageFreq"];
        
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
}
@end
