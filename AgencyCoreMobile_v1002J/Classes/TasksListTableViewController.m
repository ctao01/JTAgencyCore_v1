//
//  TasksListTableViewController.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/10/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "TasksListTableViewController.h"
#import "NewTaskViewController.h"

@interface TasksListTableViewController ()
@property (nonatomic , strong) NSArray * collections;
@end

@implementation TasksListTableViewController

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
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSString* plistPath = [[NSBundle mainBundle] pathForResource: @"ScheduledTaskList"
                                                          ofType: @"plist"];
    NSDictionary * dictionary = [[NSDictionary alloc]initWithContentsOfFile:plistPath];
    self.collections = [dictionary objectForKey:self.navigationItem.title];
    [self.tableView reloadData];
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
    return [self.collections count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.textLabel.text = [self.collections objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;

    // Configure the cell...
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewTaskViewController * vc = [self.navigationController.viewControllers objectAtIndex:0];
    vc.selectedTask = [self.collections objectAtIndex:indexPath.row];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
