//
//  Account2ViewController.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 3/27/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "SettingViewController.h"
#import "BasicCustomCell.h"
#import "PasscodeSettingViewController.h"
#import "KKPasscodeLock.h"
#import "AppDelegate.h"

@interface SettingViewController () <KKPasscodeSettingsViewControllerDelegate>

@end

@implementation SettingViewController

#pragma mark - KKPasscodeSettingsViewController Delegate

- (void)didSettingsChanged:(KKPasscodeSettingsViewController*)viewController
{
    [self.tableView reloadData];
}

#pragma mark - Life Cycle

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

//    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 32.0f)];
//    self.tableView.tableHeaderView = headerView;
    
//    UIBarButtonItem * accountItem = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(gotoAccountView)];
//    self.navigationItem.rightBarButtonItem = accountItem;
    self.navigationItem.title = @"Settings";
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 

- (void) gotoAccountView
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 1) return 2;
    else if (section == 2) return 1;
    else return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier2 = @"AccountSettingsCell";
    static NSString * CellIdentifier3 = @"DeviceSettingsCell";
    static NSString * CellIdentifier4 = @"LogoutsCell";

    UITableViewCell * cell = nil;
    if (indexPath.section == 0)
    {
        UITableViewCell * cell2 = (UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        if (cell2 == nil) cell2 = (UITableViewCell*)[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2];
        if (indexPath.row == 0) cell2.textLabel.text = @"Change Signature";
        else if (indexPath.row == 1) cell2.textLabel.text = @"Change Password";
        cell2.textLabel.backgroundColor = [UIColor clearColor];
        cell2.textLabel.textAlignment = NSTextAlignmentCenter;
        cell2.selectionStyle = UITableViewCellSelectionStyleGray;
        cell = (UITableViewCell*)cell2;
    }
    
    else if (indexPath.section == 1)
    {
        UITableViewCell * cell3 = (UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier3];
        if (cell3 == nil) cell3 = (UITableViewCell*)[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier3];
        if (indexPath.row == 0)
        {
            cell3.textLabel.text = @"Passcode";
            if ([[KKPasscodeLock sharedLock] isPasscodeRequired]) cell3.detailTextLabel.text = @"On";
            else cell3.detailTextLabel.text = @"Off";
        }
        else if (indexPath.row == 1) cell3.textLabel.text = @"Notification";
        cell3.textLabel.backgroundColor = [UIColor clearColor];
        cell3.detailTextLabel.backgroundColor = [UIColor clearColor];
        cell3.selectionStyle = UITableViewCellSelectionStyleGray;
        cell3.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell = (UITableViewCell*)cell3;
    }
    else if (indexPath.section == 2)
    {
        UITableViewCell * cell4 = (UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier4];
        if (cell4 == nil) cell4 = (UITableViewCell*)[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier4];
        cell4.textLabel.text = @"Log Out";
        cell4.textLabel.backgroundColor = [UIColor clearColor];
        cell4.textLabel.textColor = [UIColor whiteColor];
        cell4.textLabel.textAlignment = NSTextAlignmentCenter;
        cell = (UITableViewCell*)cell4;
    }
    
    
    return cell;
}


- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 0 || indexPath.section == 1)
//    {
//        cell.backgroundView = [[UIImageView alloc]init];
//        ((UIImageView*) cell.backgroundView).image = nil;
//        UIImage * backgroundImage = [[UIImage imageNamed:@"btn_Gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(0.0f, 6.0f, 0.0f, 6.0f)];
//        ((UIImageView*) cell.backgroundView).image = backgroundImage;
//    }
    if (indexPath.section == 2)
    {
        cell.backgroundView = [[UIImageView alloc]init];
        ((UIImageView*) cell.backgroundView).image = nil;
        UIImage * backgroundImage = [[UIImage imageNamed:@"btn_Red"] resizableImageWithCapInsets:UIEdgeInsetsMake(0.0f, 6.0f, 0.0f, 6.0f)];
        ((UIImageView*) cell.backgroundView).image = backgroundImage;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 42.0f;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"Axxess Home Health Management System"
                                                                message:@"Enter a new signature"
                                                               delegate:self
                                                      cancelButtonTitle:@"Cancel"
                                                      otherButtonTitles:@"Change", nil];
            alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
            [alertView show];
        }
        else
        {
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"Axxess Home Health Management System"
                                                                message:@"Change a new password"
                                                               delegate:self
                                                      cancelButtonTitle:@"Cancel"
                                                      otherButtonTitles:@"Change", nil];
            alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
            [alertView show];        }
    }
    
    else if (indexPath.section == 1 && indexPath.row == 0)
    {
        PasscodeSettingViewController * pSettings = [[PasscodeSettingViewController alloc]initWithStyle:UITableViewStyleGrouped];
        pSettings.delegate = self;
        [self.navigationController pushViewController:pSettings animated:YES];
    }
    
    else if (indexPath.section == 2)
    {
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"HasLoggedIn"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        AppDelegate * delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        [delegate displayScreen:[[NSUserDefaults standardUserDefaults]boolForKey:@"HasLoggedIn"]];
    }
}

@end
