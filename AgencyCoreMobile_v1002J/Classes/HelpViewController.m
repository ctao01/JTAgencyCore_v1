//
//  HelpViewController.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 5/14/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "HelpViewController.h"
#import "WalkThroughViewController.h"
#import "NavigationToolBarController.h"

@interface HelpViewController ()
@property (nonatomic , strong) NSArray * helpers;
@end

@implementation HelpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.helpers = [NSArray arrayWithObjects:@"Tutorial",@"Demo (Video)",@"FAQ", nil];
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
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.textLabel.text = [self.helpers objectAtIndex:indexPath.row];
    return cell;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        WalkThroughViewController * vc = [[WalkThroughViewController alloc]init];
        NavigationToolBarController * nc = [[NavigationToolBarController alloc]initWithRootViewController:vc];
        [self presentViewController:nc animated:YES completion:nil];
    }
}

@end
