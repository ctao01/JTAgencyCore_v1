//
//  NewTaskViewController.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/9/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "NewTaskViewController.h"
//#import "TasksTableViewController.h"
#import "UserListViewController.h"
#import "TaskCategoriesViewController.h"

@interface NewTaskViewController ()

@end

@implementation NewTaskViewController

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
    
    UIBarButtonItem * cancelItem = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelAddingTask)];
    self.navigationItem.rightBarButtonItem = cancelItem;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    self.navigationItem.title = @"New Task";
    self.tableView.scrollsToTop = YES;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void) dealloc
{
    self.selectedPatient = nil;
    self.selectedUser = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Actions

- (void) cancelAddingTask
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    
    if (indexPath.row == 0)
    {
        cell.textLabel.text = @"Patient";
        cell.detailTextLabel.text = self.selectedPatient ? self.selectedPatient:nil;
    }
    else if (indexPath.row == 1)
        cell.textLabel.text = @"Episode";
    else if (indexPath.row == 2)
        cell.textLabel.text = @"Date";
    else if (indexPath.row == 3)
    {
        cell.textLabel.text = @"Task";
        cell.detailTextLabel.text = self.selectedTask ? self.selectedTask : nil;
    }
    else
    {
        cell.textLabel.text = @"User";
        cell.detailTextLabel.text = self.selectedUser ? self.selectedUser : nil;

    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        UserListViewController * vc = [[UserListViewController alloc]initWithStyle:UITableViewStylePlain];
        vc.navigationItem.title = @"Patient List";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 3)
    {
        TaskCategoriesViewController * vc = [[TaskCategoriesViewController alloc]initWithStyle:UITableViewStylePlain];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 4)
    {
        UserListViewController * vc = [[UserListViewController alloc]initWithStyle:UITableViewStylePlain];
        vc.navigationItem.title = @"User List";
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    else
    {
        UITableViewController * temp = [[UITableViewController alloc]init];
        [self.navigationController pushViewController:temp animated:YES];
    }

}

@end
