//
//  TaskCategoriesViewController.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/10/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "TaskCategoriesViewController.h"
#import "TasksListTableViewController.h"

@interface TaskCategoriesViewController ()
@property (nonatomic , strong) NSArray * categories; 
@end

@implementation TaskCategoriesViewController

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
    self.categories = [NSArray arrayWithObjects:@"Nursing",@"HHA",@"MSW/Other",@"Therapy",@"Dietician",@"Orders/Care Plans",@"Daily/Outlier", nil];
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
    return [self.categories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.textLabel.text = [self.categories objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TasksListTableViewController * vc = [[TasksListTableViewController alloc]initWithStyle:UITableViewStylePlain];
    vc.navigationItem.title = [self.categories objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
