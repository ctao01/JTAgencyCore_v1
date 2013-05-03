//
//  AboutViewController.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/30/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

#pragma mark - ECSlidingViewController Method

- (IBAction)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}

#pragma mark - View Life Cycle
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 1; // Version
    else if (section == 1 || section == 2) return 2;
    else if (section == 3) return 3;
    else return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    if (indexPath.section == 0)
    {
        cell.textLabel.text = @"Version";
        cell.detailTextLabel.text = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0 )
            cell.textLabel.text = @"Terms of Service";
        else if (indexPath.row == 1)
            cell.textLabel.text = @"Privacy Policy";
    }
    else if (indexPath.section == 2)
    {
        if (indexPath.row == 0 )
            cell.textLabel.text = @"Help";
        else if (indexPath.row == 1)
            cell.textLabel.text = @"Support";
    }
    else if (indexPath.section == 3)
    {
        if (indexPath.row == 0 )
            cell.textLabel.text = @"Phone";
        else if (indexPath.row == 1)
            cell.textLabel.text = @"Email";
        else if (indexPath.row == 2)
            cell.textLabel.text = @"Address";
    }
    else 
    {
        if (indexPath.row == 0 )
            cell.textLabel.text = @"Facebook";
        else if (indexPath.row == 1)
            cell.textLabel.text = @"Twitter";
        else if (indexPath.row == 2)
            cell.textLabel.text = @"LinkedIn";
        else
            cell.textLabel.text = @"Website";
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1) return @"About Axxess Home Health";
    else if (section == 3) return @"Contact Us";
    else return @"";
}
@end
