//
//  SecondTopViewController.m
//  ECSlidingViewController
//
//  Created by Michael Enriquez on 1/23/12.
//  Copyright (c) 2012 EdgeCase. All rights reserved.
//

#import "AccountViewController.h"
#import "BasicCustomCell.h"
#import "LogInViewController.h"
#import "MenuViewController.h"
#import "SettingViewController.h"

@interface AccountViewController ()
{
    NSDictionary * tempUser; 
}
@property (nonatomic , strong) UITableView * tableView;
@end

@implementation AccountViewController

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
    self.slidingViewController.underLeftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
  }
  self.slidingViewController.underRightViewController = nil;
  
  [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

- (IBAction)revealMenu:(id)sender
{
  [self.slidingViewController anchorTopViewTo:ECRight];
}

#pragma mark - Programmatically

- (void) gotoSettings
{
    SettingViewController * vcSettings = [[SettingViewController alloc]initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:vcSettings animated:YES];
}

#pragma mark -

- (void) viewDidLoad
{
    CGRect frame = self.view.frame;
    CGRect tvFrame;
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight)
        tvFrame = CGRectMake(frame.origin.x, frame.origin.y , frame.size.width, frame.size.height);
//    if (iPHONE_UI)
    else  tvFrame = CGRectMake(frame.origin.x, frame.origin.y - 20.0f, frame.size.width, frame.size.height);
//    else if (iPAD_UI) tvFrame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    self.tableView = [[UITableView alloc]initWithFrame:tvFrame style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    UIBarButtonItem * menuItem = [[UIBarButtonItem alloc]initWithTitle:@"Menu" style:UIBarButtonItemStyleBordered target:self action:@selector(revealMenu:)];
    self.navigationItem.leftBarButtonItem = menuItem;
    self.title = @"My Account";
    
    UIBarButtonItem * settingsItem = [[UIBarButtonItem alloc]initWithTitle:@"Settings" style:UIBarButtonItemStyleBordered target:self action:@selector(gotoSettings) ];
    self.navigationItem.rightBarButtonItem = settingsItem;
    
//    LoginFieldView * view = [[LoginFieldView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 88.0f) andRadius:8.0f];
//    self.tableView.tableHeaderView = view;
    
    
    CGRect footerFrame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 120.0f);
    UIView * footerView = [[UIView alloc]initWithFrame:footerFrame];
    footerView.backgroundColor = [UIColor whiteColor];
    /*
    UIButton * btnSign = [UIButton grayStyleButtonWithTitle:@"Change Signature"];
    [btnSign setFrame:UIEdgeInsetsInsetRect(footerFrame, UIEdgeInsetsMake(20.0f, 20.0f, 0.0f, 0.0f))];
    [btnSign setFrame:CGRectMake(btnSign.frame.origin.x, btnSign.frame.origin.y, 135.0f , 44.0f)];
    [btnSign addTarget:self action:@selector(changeSignature) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:btnSign];
    
//    UIButton * btnPwd = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIButton * btnPwd = [UIButton grayStyleButtonWithTitle:@"Change Password"];
    [btnPwd setFrame:UIEdgeInsetsInsetRect(footerFrame, UIEdgeInsetsMake(20.0f, 30 + btnSign.frame.size.width, 0.0f, 20.0f))];
    [btnPwd setFrame:CGRectMake(btnPwd.frame.origin.x, btnPwd.frame.origin.y, 135.0f , 44.0f)];
    [btnPwd addTarget:self action:@selector(changePassword) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:btnPwd];
    
    UIButton * btnLogout = [UIButton redStyleButtonWithTitle:@"Log Out"];
    [btnLogout setFrame:UIEdgeInsetsInsetRect(footerFrame, UIEdgeInsetsMake(84.0f, 20.0f, 20.0f, 20.0f))];
    [btnLogout setFrame:CGRectMake(btnLogout.frame.origin.x, btnLogout.frame.origin.y, 280.0f , 44.0f)];
    [btnLogout addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:btnLogout];*/
    
    self.tableView.tableFooterView = footerView;
    
    self.tableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 44.0f, 0.0f);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    [self.view addSubview:self.tableView];
}

#pragma mark - UIButton  Actions
/*
- (void) changeSignature
{
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"Axxess Home Health Management System"
                                                        message:@"Enter a new signature"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Change", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}

- (void) changePassword
{
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"Axxess Home Health Management System"
                                                        message:@"Change a new password"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Change", nil];
    alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
    [alertView show];
}

- (void) logout
{
//    self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Home"];
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"HasLoggedIn"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
//    [self.navigationController dismissViewControllerAnimated:YES completion:^{AppDelegate * delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
//        [delegate displayScreen:[[NSUserDefaults standardUserDefaults]boolForKey:@"HasLoggedIn"]];}];
//    [self.slidingViewController dismissViewControllerAnimated:YES completion:^{
//        
//    }];
    
    AppDelegate * delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [delegate displayScreen:[[NSUserDefaults standardUserDefaults]boolForKey:@"HasLoggedIn"]];
}
*/
#pragma mark - UITableView DataSource 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section == 0) return 4;
//    else return 20;
    return 4;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cell1ID = @"MyAccountCell";
    static NSString * cell2ID = @"ActivityCell";
    
    UITableViewCell * cell;
    if (indexPath.section == 0)
    {
        BasicCustomCell * accountCell = [tableView dequeueReusableCellWithIdentifier:cell1ID];
        if (accountCell == nil)
            accountCell = [[BasicCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell1ID];
        
        switch (indexPath.row) {
            case 0:
            {
                accountCell.titleLabel.text = @"Name";
                accountCell.dataLabel.text = @"Edem Jimbo";
                accountCell.dataLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
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
                accountCell.dataLabel.text = @"8035 E R L Thomton Fwy # 147 Dallas,Texas 76006";
                accountCell.dataLabel.lineBreakMode = NSLineBreakByWordWrapping;
                accountCell.dataLabel.numberOfLines = 0.0f;
            }
                break;
            case 3:
            {
                accountCell.titleLabel.text = @"Phone";
                accountCell.dataLabel.text = @"(214)660-4400";
            }
                break;
                
            default:
                break;
        }
        accountCell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = (UITableViewCell*)accountCell;
    }
    else
    {
        UITableViewCell * cell2 = [tableView dequeueReusableCellWithIdentifier:cell2ID];
        if (cell2 == nil)
            cell2 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell2ID];
        cell2.textLabel.text = @"Recent Activities";
        cell = (UITableViewCell*)cell2;
    }
    /*
    BasicCustomCell * accountCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (accountCell == nil)
        accountCell = [[BasicCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    
    switch (indexPath.row) {
        case 0:
        {
            accountCell.titleLabel.text = @"Name";
            accountCell.dataLabel.text = @"Edem Jimbo";
            accountCell.dataLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
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
            accountCell.dataLabel.text = @"8035 E R L Thomton Fwy # 147 Dallas,Texas 76006";
            accountCell.dataLabel.lineBreakMode = NSLineBreakByWordWrapping;
            accountCell.dataLabel.numberOfLines = 0.0f;
        }
            break;
        case 3:
        {
            accountCell.titleLabel.text = @"Phone";
            accountCell.dataLabel.text = @"(214)660-4400";
        }
            break;
            
        default:
            break;
    }
    accountCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return accountCell;*/
    return cell;
}

#pragma mark - UITableView Delegate

//- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if (section == 1) return @"Recent Activities";
//    else return nil;
//}
//
//- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section == 1) return 60.0f;
//    else return 44.0f;
//}

@end
