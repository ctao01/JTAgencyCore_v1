//
//  AboutViewController.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/30/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "AboutViewController.h"
#import "AxxessContactCell.h"
#import "HelpViewController.h"

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

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];    
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(receiveTestNotification:) name:@"TestNotification" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSNotificationCenter 

- (void) receiveTestNotification:(NSNotification*)notification
{
    if ([[notification name]isEqualToString:@"TestNotification" ])
        [self.tableView reloadData];
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
    else if (section == 1) return 1;
    else if (section == 2) return 2;
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
        cell = [[AxxessContactCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Axxess_Contact_Cell"];
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

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) return 90.0f;
    else return 42.0f;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1) return @"About Axxess Home Health";
    else if (section == 3) return @"Contact Us";
    else return @"";
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2)
    {
        if (indexPath.row == 0 )
        {
            HelpViewController * vc = [[HelpViewController alloc]initWithStyle:UITableViewStyleGrouped];
            [self.navigationController pushViewController:vc animated:YES];
        }
            
        
    }
}

@end
