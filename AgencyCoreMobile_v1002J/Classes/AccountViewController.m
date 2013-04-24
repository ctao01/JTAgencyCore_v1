//
//  SecondTopViewController.m
//  ECSlidingViewController
//
//  Created by Michael Enriquez on 1/23/12.
//  Copyright (c) 2012 EdgeCase. All rights reserved.
//

#import "AccountViewController.h"
#import "BasicOneLineCell.h"
#import "LogInViewController.h"
#import "MenuViewController.h"
#import "SettingViewController.h"
#import "NavigationControllerWithoutRotation.h"

#import "AgencyCoreEntries.h"
#import "PasscodeSettingsViewController.h"
#import "KKPasscodeLock.h"
#import "LogInViewController.h"
#import "AppDelegate.h"

@interface AccountViewController () <KKPasscodeSettingsViewControllerDelegate>
{
    NSDictionary * tempUser; 
}
//@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) CurrentUser * currentUser;
@end

@implementation AccountViewController

#pragma mark - KKPasscodeSettingsViewController Delegate

- (void)didSettingsChanged:(KKPasscodeSettingsViewController*)viewController
{
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
    self.slidingViewController.underLeftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
  }
  self.slidingViewController.underRightViewController = nil;
  
  [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(receiveTestNotification:) name:@"TestNotification" object:nil];
}

- (IBAction)revealMenu:(id)sender
{
  [self.slidingViewController anchorTopViewTo:ECRight];
}

#pragma mark - Programmatically

- (void) gotoSettings
{
    SettingViewController * vcSettings = [[SettingViewController alloc]initWithStyle:UITableViewStyleGrouped];
//    ACNavigationController * ncSettings = [[ACNavigationController alloc]initWithRootViewController:vcSettings];
    
    [self.navigationController pushViewController:vcSettings animated:YES];
//    [self.navigationController presentViewController:ncSettings animated:YES completion:^{}];
}

- (void) receiveTestNotification:(NSNotification*)notification
{
    if ([[notification name]isEqualToString:@"TestNotification" ])
        [self.tableView reloadData];
}

#pragma mark -

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem * menuItem = [[UIBarButtonItem alloc]initWithTitle:@"Menu" style:UIBarButtonItemStyleBordered target:self action:@selector(revealMenu:)];
    self.navigationItem.leftBarButtonItem = menuItem;
    self.title = @"My Account";
    
    UIBarButtonItem * settingsItem = [[UIBarButtonItem alloc]initWithTitle:@"Settings" style:UIBarButtonItemStyleBordered target:self action:@selector(gotoSettings) ];
    self.navigationItem.rightBarButtonItem = settingsItem;
    
    CGRect footerFrame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 120.0f);
    UIView * footerView = [[UIView alloc]initWithFrame:footerFrame];
    footerView.backgroundColor = [UIColor whiteColor];
    
//    self.tableView.tableFooterView = footerView;
    
    self.tableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 44.0f, 0.0f);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;

    self.currentUser = [AgencyCoreEntries createCurrentUser];
    NSLog(@"%@",self.currentUser);
}

#pragma mark - UITableView DataSource 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 4;
    if (section == 1 || section == 2) return 2;
    else if (section == 3) return 1;
    else return 0;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
    
    if (indexPath.section == 0)
    {
        
        //    static NSString * cell = @"MyAccountCell";
        static NSString * iPhone_portrait_cell = @"iPhone_Portrait_Cell";
        static NSString * iPhone_landscape_cell = @"iPhone_Landscape_Cell";
        static NSString * iPad_portrait_cell = @"iPad_Portrait_Cell";
        static NSString * iPad_landscape_cell = @"iPad_Landscape_Cell";
        
        //    BasicCustomCell * accountCell = [tableView dequeueReusableCellWithIdentifier:cell1ID];
        BasicOneLineCell * accountCell;
        
        if (iPHONE_UI && UserInterface_Portrait)
            accountCell = [tableView dequeueReusableCellWithIdentifier:iPhone_portrait_cell];
        else if (iPHONE_UI && UserInterface_Landscape)
            accountCell =  [tableView dequeueReusableCellWithIdentifier:iPhone_landscape_cell];
        else if (iPAD_UI && UserInterface_Portrait)
            accountCell = [tableView dequeueReusableCellWithIdentifier:iPad_portrait_cell];
        else if (iPAD_UI && UserInterface_Landscape)
            accountCell = [tableView dequeueReusableCellWithIdentifier:iPad_landscape_cell];
        
        if (accountCell == nil)
        {
            if (iPHONE_UI && UserInterface_Portrait)
                accountCell = [[BasicOneLineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iPhone_portrait_cell];
            else if (iPHONE_UI && UserInterface_Landscape)
                accountCell = [[BasicOneLineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iPhone_landscape_cell];
            else if (iPAD_UI && UserInterface_Portrait)
                accountCell = [[BasicOneLineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iPad_portrait_cell];
            else if (iPAD_UI && UserInterface_Landscape)
                accountCell = [[BasicOneLineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iPad_landscape_cell];
            else
                accountCell = nil;
        }
        
        switch (indexPath.row) {
            case 0:
            {
                accountCell.titleLabel.text = @"Name";
                accountCell.dataLabel.text = [NSString stringWithFormat:@"%@ %@ %@",self.currentUser.firstName, self.currentUser.middleName, self.currentUser.lastName];
                accountCell.dataLabel.font = ACFontDefaultBold18;
            }
                break;
            case 1:
            {
                accountCell.titleLabel.text = @"Agency";
                accountCell.dataLabel.text = @"Sunny Bobo Agnecy";
            }
                break;
            case 2:
            {
                accountCell.titleLabel.text = @"Address";
                //            accountCell.dataLabel.text = @"8035 E R L Thomton Fwy # 147 Dallas,Texas 76006";
                accountCell.dataLabel.text = self.currentUser.location;
                
                accountCell.dataLabel.lineBreakMode = NSLineBreakByWordWrapping;
                accountCell.dataLabel.numberOfLines = 0.0f;
            }
                break;
            case 3:
            {
                accountCell.titleLabel.text = @"Phone";
                //            accountCell.dataLabel.text = @"(214)660-4400";
                accountCell.dataLabel.text = self.currentUser.home;
            }
                break;
                
            default:
                break;
        }
        accountCell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = accountCell;
    }
    else if (indexPath.section == 1)
    {
        static NSString * CellIdentifier2 = @"AccountSettingsCell";
        cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        if (cell == nil ) cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2];
        if (indexPath.row == 0) cell.textLabel.text = @"Change Signature";
        else if (indexPath.row == 1) cell.textLabel.text = @"Change Password";
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    else if (indexPath.section == 2)
    {
        static NSString * CellIdentifier3 = @"DeviceSettingsCell";
        cell = (UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier3];
        if (cell == nil) cell = (UITableViewCell*)[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier3];
        if (indexPath.row == 0)
        {
            cell.textLabel.text = @"Passcode";
            if ([[KKPasscodeLock sharedLock] isPasscodeRequired]) cell.detailTextLabel.text = @"On";
            else cell.detailTextLabel.text = @"Off";
        }
        else if (indexPath.row == 1) cell.textLabel.text = @"Notification";
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if (indexPath.section == 3)
    {
        static NSString * CellIdentifier4 = @"LogoutsCell";
        cell = (UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier4];
        if (cell == nil) cell = (UITableViewCell*)[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier4];
        cell.textLabel.text = @"Log Out";
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return cell;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
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
    
    else if (indexPath.section == 2 && indexPath.row == 0)
    {
        PasscodeSettingsViewController * pSettings = [[PasscodeSettingsViewController alloc]initWithStyle:UITableViewStyleGrouped];
        pSettings.delegate = self;
        [self.navigationController pushViewController:pSettings animated:YES];
    }
    
    else if (indexPath.section == 3)
    {
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"HasLoggedIn"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        AppDelegate * delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        [delegate.navigation viewDidAppear:YES];
        //        [delegate displayScreen:[[NSUserDefaults standardUserDefaults]boolForKey:@"HasLoggedIn"]];
        //        LogInViewController * vc = [[LogInViewController alloc]init];
        //        UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:vc];
        //        [self.navigationController presentViewController:nc animated:NO completion:^{}];
        
        
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 42.0f;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3)
    {
        cell.backgroundView = [[UIImageView alloc]init];
        ((UIImageView*) cell.backgroundView).image = nil;
        UIImage * backgroundImage = [[UIImage imageNamed:@"btn_Red"] resizableImageWithCapInsets:UIEdgeInsetsMake(0.0f, 6.0f, 0.0f, 6.0f)];
        ((UIImageView*) cell.backgroundView).image = backgroundImage;
    }
}

@end
