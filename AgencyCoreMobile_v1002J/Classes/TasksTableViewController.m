//
//  TasksTableViewController.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/9/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "TasksTableViewController.h"

@interface TasksTableViewController ()
{
    BOOL categorySelected;
}
@property (nonatomic , retain) NSArray * taskCollections;
@property (nonatomic , retain) NSIndexPath * selectedIndexPath;

@end

@implementation TasksTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.taskCollections = [NSArray arrayWithObjects:@"HHA",@"NSW/Other",@"Therapy",@"Dietician",@"Order/Care Plans",@"Daily/Outlier", nil];
    categorySelected = NO;
    self.selectedIndexPath = nil;
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0 ) return [self.taskCollections count];
    else
    {
        if (self.selectedIndexPath == nil) return 0;
        else return [tableView numberOfRowsInSection:0];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    if (indexPath.section == 0)
        cell.textLabel.text = [self.taskCollections objectAtIndex:indexPath.row];
    else
        cell.textLabel.text = @"Sub-Tasks";
    // Configure the cell...
    
    return cell;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (self.selectedIndexPath)
        {
            UITableViewCell* uncheckCell =[tableView  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndexPath.row inSection:0]];
            uncheckCell.accessoryType =UITableViewCellAccessoryNone;
            self.selectedIndexPath = nil;
        }
        if([[NSIndexPath indexPathForRow:self.selectedIndexPath.row inSection:0] isEqual:indexPath])
        {
            self.selectedIndexPath = nil;
        }
        else
        {
            UITableViewCell* cell =[tableView cellForRowAtIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            self.selectedIndexPath = [NSIndexPath indexPathForRow:self.selectedIndexPath.row inSection:0];
        }
        [self.tableView reloadData];
    }
}

@end
